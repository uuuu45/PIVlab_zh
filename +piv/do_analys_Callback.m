function do_analys_Callback(~, ~, ~)
handles=gui.gethand;
set(handles.progress, 'String','帧进度：N/A');
set(handles.overall, 'String','总进度：N/A');
set(handles.totaltime, 'String','剩余时间：N/A');
set(handles.messagetext, 'String','');
if get(handles.algorithm_selection,'Value') == 1 || get(handles.algorithm_selection,'Value') == 3 || get(handles.algorithm_selection,'Value') == 4 %fft multi or dcc or wOFV
	set(handles.AnalyzeAll,'String','Analyze all frames');
end
if get(handles.algorithm_selection,'Value') == 2 %ensemble
	set(handles.AnalyzeAll,'String','Start ensemble analysis');
end
if gui.retr('parallel')==1
	set(handles.update_display_checkbox,'Visible','Off')
end
gui.switchui('multip05')

