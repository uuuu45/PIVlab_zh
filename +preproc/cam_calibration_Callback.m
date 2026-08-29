function cam_calibration_Callback(caller, ~, ~)
handles=gui.gethand;
if strcmpi(caller.Text, '相机 1')
    gui.put('current_cam_nr',1);
    handles.calib_undist_cam_label.String = '当前相机：相机 1';
elseif strcmpi(caller.Text, '相机 2')
    gui.put('current_cam_nr',2);
    handles.calib_undist_cam_label.String = '当前相机：相机 2';
end
gui.switchui('multip26')