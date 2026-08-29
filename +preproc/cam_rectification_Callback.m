function cam_rectification_Callback(caller, ~, ~)
handles=gui.gethand;
filepath=gui.retr('filepath');
if size(filepath,1) >1
    if strcmpi(caller.Text, '相机 1')
        gui.put('current_cam_nr',1);
        handles.calib_rect_cam_label.String = '当前相机：相机 1';
    elseif strcmpi(caller.Text, '相机 2')
        handles.calib_rect_cam_label.String = '当前相机：相机 2';
        gui.put('current_cam_nr',2);
    end
    gui.switchui('multip27')
else
    gui.custom_msgbox('error',getappdata(0,'hgui'),'没有 PIV 图像','请先加载一些 PIV 图像。','modal');
end