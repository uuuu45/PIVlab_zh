function camera_setup_Callback(~,~,~)
camera_type=gui.retr('camera_type');
if strcmp(camera_type,'chronos')
    PIVlab_capture_chronos_settings_GUI
elseif strcmp(camera_type,'OPTOcam')
    PIVlab_capture_OPTOcam_settings_GUI
elseif strcmp(camera_type,'OPTRONIS')
    camera_sub_type=gui.retr('camera_sub_type');
    if endsWith(camera_sub_type, '-bitflow')
        PIVlab_capture_OPTRONIS_bitflow_settings_GUI
    elseif ~verLessThan('matlab','25')
        PIVlab_capture_OPTRONIS_settings_GUI
    else
        gui.custom_msgbox('warn',getappdata(0,'hgui'),'需要更新的 Matlab','OPTRONIS 相机至少需要 Matlab R2025a 才能设置位深和增益。','modal');
    end
elseif strcmp(camera_type,'pco_panda') || strcmp(camera_type,'pco_edge26')
    PIVlab_capture_panda_settings_GUI
else
    gui.custom_msgbox('error',getappdata(0,'hgui'),'不可用','所选相机型号不支持此功能。','modal');
end