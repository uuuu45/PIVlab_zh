function cam_rectification_show_points_Callback (~,~,~)
handles=gui.gethand;
cameraParams=gui.retr('cameraParams');
cam_selected_rectification_image = gui.retr('cam_selected_rectification_image');
if ~isempty (cameraParams) && ~isempty(cam_selected_rectification_image)
    %detector = vision.calibration.monocular.CharucoBoardDetector();
    patternDims = [str2double(handles.calib_rows.String),str2double(handles.calib_columns.String)];
    if contains(handles.calib_boardtype.String{handles.calib_boardtype.Value}, 'DICT_4X4_1000')
        markerFamily = 'DICT_4X4_1000';
    end
    checkerSize = str2double(handles.calib_checkersize.String);
    markerSize = str2double(handles.calib_markersize.String);
    originCheckerColor = handles.calib_origincolor.String{handles.calib_origincolor.Value} ;

    if markerSize >= checkerSize
        gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','标记尺寸必须小于棋盘格尺寸。','modal');
        gui.toolsavailable(1)
        return
    end
    minMarkerID = 0;

    %% Slower but more robust due to image preprocessing:
    %%{
    tmp_img=imread(cam_selected_rectification_image);
    if size(tmp_img,3) > 1
        tmp_img = rgb2gray(tmp_img);
    end
    %figure;imshow(tmp_img)

    tmp_img=imadjust(tmp_img);
    %figure;imshow(tmp_img)
    tmp_img=imsharpen(tmp_img);
    %figure;imshow(tmp_img)
    %figure(getappdata(0,'hgui'))
    imagePoints1 = detectCharucoBoardPoints(tmp_img,patternDims,markerFamily,checkerSize,markerSize, 'MinMarkerID', minMarkerID, 'OriginCheckerColor', originCheckerColor,'RefineCorners',true,'ResolutionPerBit',16,'MarkerSizeRange',[0.005 1]);
    %%}
    %% faster but no preproc possible
    %[imagePoints1, ~] = detectPatternPoints(detector, cam_selected_rectification_image, patternDims, markerFamily, checkerSize, markerSize, 'MinMarkerID', minMarkerID, 'OriginCheckerColor', originCheckerColor);
    if isempty(imagePoints1)
        gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','未检测到 ChArUco 标记。','modal');
        return
    end
    ax = gui.retr('pivlab_axis');
    imshow(imread(cam_selected_rectification_image),'Parent',ax)
    hold(ax,'on')
    plot(ax,imagePoints1(:,1),imagePoints1(:,2),'yo','MarkerFaceColor','y','Markersize',10)
    plot(ax,imagePoints1(:,1),imagePoints1(:,2),'rx','MarkerSize',20,'LineWidth',2)
    hold(ax,'off')
else
    gui.custom_msgbox('error',getappdata(0,'hgui'),'错误','未启用相机标定，或未加载用于图像校正的图像。','modal');
end