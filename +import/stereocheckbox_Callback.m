function stereocheckbox_Callback (~,caller,~)
stereomode=gui.retr('stereomode');
if isempty(stereomode)
    stereomode=0;
end
button = gui.custom_msgbox('quest',getappdata(0,'hgui'),'警告','切换模式将重置当前结果和设置。继续？','modal',{'是','否'},'否');
if strcmpi(button,'是')
    gui.put('stereomode',caller.Source.Value); % enable or disable stereo PIV mode, write to GUI variables.
    'Here, all settings in the GUI must be cleared.'
else % omit changing the box value
    caller.Source.Value = stereomode;
end

