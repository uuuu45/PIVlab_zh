function clear_everything_Callback(~, ~, ~)
gui.put ('resultslist', []); %clears old results
gui.put ('derived', []);
handles=gui.gethand;
set(handles.progress, 'String','帧进度：N/A');
set(handles.overall, 'String','总进度：N/A');
set(handles.totaltime, 'String','剩余时间：N/A');
set(handles.messagetext, 'String','');
set (handles.amount_nans, 'BackgroundColor',[0.9 0.9 0.9])
set (handles.amount_nans,'string','')
gui.sliderdisp(gui.retr('pivlab_axis'))