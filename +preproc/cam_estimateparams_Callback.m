function cam_estimateparams_Callback(~, ~, ~)
warning off 'MATLAB:imagesci:imfinfo:unknownXMPpacket'
handles=gui.gethand;
cam_selected_target_images = gui.retr('cam_selected_target_images');
originCheckerColor = handles.calib_origincolor.String{handles.calib_origincolor.Value};
if strcmpi (originCheckerColor,'white') && mod(str2double(handles.calib_rows.String),2)~=0
    gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','当原点颜色为白色时，ChArUco 标定板的第 1 维行数必须为偶数。','modal');
    return
end
if str2double(handles.calib_rows.String)<3 || str2double(handles.calib_columns.String)<3
    gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','ChArUco 标定板的行数和列数必须 >= 3。','modal');
    return
end
if isempty(cam_selected_target_images) || ~iscell(cam_selected_target_images) || numel(cam_selected_target_images) <=1
    gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','所选标定板图像不足。','modal');
    return
end

% Detect calibration pattern in images
if ~isempty(cam_selected_target_images)
    handles.calib_usecalibration.Value = 0;
    gui.toolsavailable(0,'正在检测标记...');drawnow;
    detector = vision.calibration.monocular.CharucoBoardDetector();
    patternDims = [str2double(handles.calib_rows.String),str2double(handles.calib_columns.String)];
    if contains(handles.calib_boardtype.String{handles.calib_boardtype.Value}, 'DICT_4X4_1000')
        markerFamily = 'DICT_4X4_1000';
    end
    checkerSize = str2double(handles.calib_checkersize.String);
    markerSize = str2double(handles.calib_markersize.String);
    if markerSize >= checkerSize
        gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','标记尺寸必须小于棋盘格尺寸。','modal');
        gui.toolsavailable(1)
        return
    end
    minMarkerID = 0;
    for i=1:numel(cam_selected_target_images)
        tmp_img=imread(cam_selected_target_images{i});
        tmp_img=tmp_img(:,:,1);
        tmp_img=imadjust(tmp_img);
        [detectionOK,qr_markerFamily, qr_originCheckerColor,qr_patternDims,qr_checkerSize,qr_markerSize,~] = preproc.cam_get_charuco_info_from_QRcode (tmp_img);
        %check if it differs from manually entered numbers
        if detectionOK
            if  ~strcmp(markerFamily,qr_markerFamily) || ~strcmp(originCheckerColor,qr_originCheckerColor) ||  patternDims(1) ~= qr_patternDims(1) ||  patternDims(2) ~= qr_patternDims(2) || checkerSize ~= qr_checkerSize || markerSize ~= qr_markerSize
                button = gui.custom_msgbox('quest',getappdata(0,'hgui'),'警告',['用户提供的 Charuco 标定板信息与标定板上 QR 码中的信息不一致。' newline newline '是否使用标定板上 QR 码中的信息？'],'modal',{'是','否'},'是');
                if strmatch(button,'是')==1
                    markerFamily = qr_markerFamily;
                    originCheckerColor = qr_originCheckerColor;
                    patternDims = qr_patternDims;
                    checkerSize = qr_checkerSize;
                    markerSize = qr_markerSize;
                    if strcmp(originCheckerColor,'Black')
                        handles.calib_origincolor.Value = 1;
                    elseif strcmp(originCheckerColor,'White')
                        handles.calib_origincolor.Value = 2;
                    end
                    handles.calib_rows.String = num2str(patternDims(1));
                    handles.calib_columns.String = num2str(patternDims(2));
                    if strcmp(markerFamily,'DICT_4X4_1000')
                        handles.calib_boardtype.Value = 1;
                    end
                    handles.calib_checkersize.String = num2str(checkerSize);
                    handles.calib_markersize.String = num2str(markerSize);
                end
            else
                disp('QR info and user info match.')
            end
            break
        end
    end
    %% Slower but more robust due to image preprocessing:
    %%{
    if isMATLABReleaseOlderThan("R2025b")
        fig = uifigure;
        d = uiprogressdlg(fig,'Title','ChArUco 标定板图案检测...','Message','正在开始 ChArUco 标定板图案检测...');
    else
        d = uiprogressdlg(gcf,'Title','ChArUco 标定板图案检测...','Message','正在开始 ChArUco 标定板图案检测...');
    end

    imagesUsed=false(numel(cam_selected_target_images),1);
    imagePoints=[];
    for i=1:numel(cam_selected_target_images)
        tmp_img=imread(cam_selected_target_images{i});
        tmp_img=tmp_img(:,:,1);
        tmp_img=imadjust(tmp_img);
        try
            imagePoints_single = detectCharucoBoardPoints(tmp_img,patternDims,markerFamily,checkerSize,markerSize, 'MinMarkerID', minMarkerID, 'OriginCheckerColor', originCheckerColor,'ResolutionPerBit',16,'MarkerSizeRange',[0.005 1]);
        catch ME
            gui.custom_msgbox('error',getappdata(0,'hgui'),'错误',ME.message,'modal','OK');
            gui.toolsavailable(1)
            return
        end
        if numel(imagePoints_single)>0
            if numel(imagePoints)==0
                imagePoints(:,:,end)=imagePoints_single;
            else
                imagePoints(:,:,end+1)=imagePoints_single;
            end
            imagesUsed(i)=true;
        end
        [~,name,ext] = fileparts(cam_selected_target_images{i});
        percentage_detected=  round(numel(find(~isnan(imagePoints_single)))  / (numel(imagePoints_single)+0.00001) * 100);
        d.Message = [name ext '  -->  '  num2str(percentage_detected) ' % 有效标记。' ];
        d.Value=i/numel(cam_selected_target_images);
    end
    if isMATLABReleaseOlderThan("R2025b")
        close(fig)
    else
        close(d)
    end
    %debug
    %{
		for i=1:size(imagePoints,3)
			figure;
			imshow(imread(cam_selected_target_images{i}));
			hold on;
			plot(imagePoints(:,1,i), imagePoints(:,2,i),'ro');
			legend('检测到的点','重投影点');
			hold off;
		end
    %}
    %%}
    %% Faster, but dark images are ignored:
    %[imagePoints, imagesUsed] = detectPatternPoints(detector, cam_selected_target_images, patternDims, markerFamily, checkerSize, markerSize, 'MinMarkerID', minMarkerID, 'OriginCheckerColor', originCheckerColor);
    if isempty(imagePoints)
        gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','未检测到 ChArUco 标记。','modal');
        gui.toolsavailable(1)
        return
    end
    gui.toolsavailable(1)
    gui.toolsavailable(0,'正在计算相机参数...');drawnow;
    imageFileNames = cam_selected_target_images(imagesUsed);

    % Read the first image to obtain image size
    originalImage = imread(cam_selected_target_images{1});
    [mrows, ncols, ~] = size(originalImage);

    % Generate world coordinates for the planar pattern keypoints
    worldPoints = generateWorldPoints(detector, 'PatternDims', patternDims, 'CheckerSize', checkerSize);
    % Calibrate the camera
    use_tilted_model = logical(get(handles.calib_use_tilted_model, 'Value'));
    try
        [cameraParams, imagesUsed, stats] = opencv.pivlab_estimateCameraParameters(imagePoints, worldPoints, [mrows, ncols], 'use_tilted_model', use_tilted_model);
        gui.toolsavailable(1)
        gui.toolsavailable(0,'正在优化相机参数...');drawnow;
        imageFileNames = imageFileNames(imagesUsed);
        %errors = cameraParams.ReprojectionErrors;
        errors = stats.ReprojectionErrors;
        numImages = size(errors, 3);
        meanErrorPerImage = zeros(numImages, 1);
        for i = 1:numImages
            e = errors(:, :, i);
            meanErrorPerImage(i) = mean(sqrt(sum(e.^2, 2)),'omitnan');
        end
        threshold = mean(meanErrorPerImage) + 1.5*std(meanErrorPerImage);
        badImages = find(meanErrorPerImage > threshold);
        goodImages = find(meanErrorPerImage <= threshold);
        if numel(badImages)>0 && numel(goodImages)>3 %if some images have been bad
            disp(['正在跳过 ' num2str(numel(badImages)) ' 幅重投影误差过高的图像。'])
            imagePoints = imagePoints(:, :, goodImages);
            imageFileNames = imageFileNames(goodImages);
            [cameraParams, imagesUsed, stats] = opencv.pivlab_estimateCameraParameters(imagePoints, worldPoints, [mrows, ncols], cameraParams, 'use_tilted_model', use_tilted_model);
            imageFileNames = imageFileNames(imagesUsed);
            disp('使用的图像：')
            for i=1:numel(imageFileNames)
                disp(imageFileNames{i})
            end
        end

        gui.put('cameraParams',cameraParams);
        gui.put('cameraStats',stats);
        gui.put('cam_use_tilted_model', use_tilted_model);
        gui.put('cam_tilted_D',   stats.D_full);
        gui.put('cam_K_opencv',   stats.K_opencv);

        ax = gui.retr('pivlab_axis');
        imshow(imread(imageFileNames{1}),'Parent',ax);
        hold(ax,'on');
        plot(ax,imagePoints(:,1,1), imagePoints(:,2,1),'go');
        plot(ax,stats.ReprojectedPoints(:,1,1),stats.ReprojectedPoints(:,2,1),'r+');
        legend(ax,'检测到的点','重投影点');
        hold(ax,'off');

        possible_grid_points = (patternDims(1)-1) * (patternDims(2)-1) * sum(imagesUsed);
        detected_grid_points = sum(~isnan(imagePoints(:)))/2;
        percentage_detected=round(detected_grid_points/possible_grid_points*100,1);

        err = stats.ReprojectionErrors;
        errNorm = sqrt(err(:,1,:).^2 + err(:,2,:).^2);
        meanReprojError = mean(errNorm(:), 'omitnan');
        if meanReprojError > 2 %valid solution, but poor fit -> warn and explain likely cause
            diag = preproc.cam_diagnose_calibration_geometry(imagePoints, worldPoints, [mrows, ncols]);
            gui.custom_msgbox('warn',getappdata(0,'hgui'),'标定可能不可靠',...
                [{['标定完成，但平均重投影误差较高（' num2str(round(meanReprojError,2)) ' 像素）。']; ''}; diag.message(:)],...
                'modal',{'OK'},'OK');
        else
            gui.custom_msgbox('msg',getappdata(0,'hgui'),'成功',{'成功。' ;  ['检测到 ' num2str(percentage_detected) '% 的棋盘格。' ] ; ['平均重投影误差：' num2str(round(meanReprojError,2)) ' px']},'modal',{'OK'},'OK');
        end
    catch ME
        if strcmp(ME.identifier,'PIVlab:calibration:degenerate') || contains(ME.message,'Principal point must be within the image')
            %ill-conditioned image set: explain the specific cause instead of the cryptic OpenCV message
            diag = preproc.cam_diagnose_calibration_geometry(imagePoints, worldPoints, [mrows, ncols]);
            gui.custom_msgbox('error',getappdata(0,'hgui'),'标定失败',diag.message,'modal',{'OK'},'OK');
        else
            gui.custom_msgbox('error',getappdata(0,'hgui'),'错误',{'相机标定出现问题： ' ;' '; ME.message},'modal');
        end
    end
    gui.toolsavailable(1)
else
    gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','未加载标定图像数据。','modal');
end