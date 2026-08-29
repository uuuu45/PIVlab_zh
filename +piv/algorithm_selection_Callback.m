function algorithm_selection_Callback(hObject, ~, ~)
handles=gui.gethand;
selection=get(hObject,'Value');
batchModeActive=gui.retr('batchModeActive');
if isempty (batchModeActive)
	batchModeActive = 0;
end
if selection ==1 % piv fft multi
	set(handles.uipanel42,'visible','on')
	set(handles.uipanel41,'visible','on')
	set(handles.CorrQuality,'visible','on')
	set(handles.text914,'visible','on')
	set(handles.mask_auto_box,'visible','on')
	%set(handles.AnalyzeAll,'visible','on')
	set(handles.AnalyzeSingle,'visible','on')
	set(handles.Settings_Apply_current,'visible','on')
	set(handles.text14,'visible','on')
	set(handles.subpix,'visible','on')
	set(handles.uipanel_ofv1,'visible','off')
    set(handles.uipanel_ofv2,'visible','off')
	set(handles.textSuggest,'visible','on')
	set(handles.SuggestSettings,'visible','on')
	set(handles.checkbox_uncertainty,'visible','on')
	if get(handles.checkbox26,'value') ~=0
		set(handles.repeat_last,'Enable','on')
		set(handles.edit52x,'Enable','on')
	end
	piv.dispinterrog
end
if selection ==2 % ensemble
	set(handles.uipanel42,'visible','on')
	set(handles.uipanel41,'visible','on')
	set(handles.CorrQuality,'visible','on')
	set(handles.text914,'visible','on')
	set(handles.mask_auto_box,'visible','on')
	set(handles.repeat_last,'Value',0)
	set(handles.repeat_last,'Enable','off')
	set(handles.edit52x,'Enable','off')
	%set(handles.AnalyzeAll,'visible','off')
	set(handles.AnalyzeSingle,'visible','off')
	set(handles.Settings_Apply_current,'visible','off')
	set(handles.text14,'visible','on')
	set(handles.subpix,'visible','on')
	set(handles.uipanel_ofv1,'visible','off')
    set(handles.uipanel_ofv2,'visible','off')
	set(handles.textSuggest,'visible','on')
	set(handles.SuggestSettings,'visible','on')
	set(handles.checkbox_uncertainty,'visible','off')
	piv.dispinterrog
end
if selection==3 % DCC
	set(handles.uipanel42,'visible','off')
	set(handles.uipanel41,'visible','on')
	set(handles.CorrQuality,'visible','off')
	set(handles.text914,'visible','off')
	set(handles.mask_auto_box,'visible','off')
	%set(handles.AnalyzeAll,'visible','on')
	set(handles.AnalyzeSingle,'visible','on')
	set(handles.Settings_Apply_current,'visible','on')
	set(handles.text14,'visible','on')
	set(handles.subpix,'visible','on')
	set(handles.uipanel_ofv1,'visible','off')
    set(handles.uipanel_ofv2,'visible','off')
	set(handles.textSuggest,'visible','on')
	set(handles.SuggestSettings,'visible','on')
	set(handles.checkbox_uncertainty,'visible','off')
	piv.dispinterrog
end
if selection ==4 %wOFV
	set(handles.uipanel_ofv1,'visible','on')
    set(handles.uipanel_ofv2,'visible','on')
	set(handles.uipanel42,'visible','off')
	set(handles.uipanel41,'visible','off')
	set(handles.CorrQuality,'visible','off')
	set(handles.text914,'visible','off')
	set(handles.mask_auto_box,'visible','off')
	%set(handles.AnalyzeAll,'visible','on')
	set(handles.AnalyzeSingle,'visible','on')
	set(handles.Settings_Apply_current,'visible','on')
	set(handles.text14,'visible','off')
	set(handles.subpix,'visible','off')
	set(handles.textSuggest,'visible','off')
	set(handles.SuggestSettings,'visible','on')
	set(handles.checkbox_uncertainty,'visible','off')
	delete (findobj('tag','intareadispl'))%do not display visuals about interrogation area
end
%suggestion to reduce vector display density
current_vector_setting=get(handles.nthvect,'String');
if selection ==4 %wOFV
	if ~strcmp(current_vector_setting,'5') && ~batchModeActive
		ans_w = gui.custom_msgbox('quest',getappdata(0,'hgui'),'矢量显示密度',['wOFV 每个像素生成一个矢量。不建议显示所有矢量。' newline newline '需要我为您降低矢量显示密度吗？' newline newline '您可以通过 绘图 -> 修改绘图外观 -> 每第 n 个矢量绘图 手动更改'],'modal',{'是','否'},'是');
		if strcmp(ans_w,'是')
			set(handles.nthvect,'String',5)
		end
	end
else
	if ~strcmp(current_vector_setting,'1') && ~batchModeActive
		ans_w = gui.custom_msgbox('quest',getappdata(0,'hgui'),'矢量显示密度',['您目前没有绘制每个计算出的矢量。' newline newline '需要我为您应用标准矢量显示设置吗？' newline newline '您可以通过 绘图 -> 修改绘图外观 -> 每第 n 个矢量绘图 手动更改'],'modal',{'是','否'},'是');
		if strcmp(ans_w,'是')
			set(handles.nthvect,'String',1)
		end
	end
end

%In Basic interface mode, re-assert the hidden-element list. Otherwise
%changing the algorithm here would re-show controls that Basic mode hides
%(text14, subpix, mask_auto_box, text914, CorrQuality, ...).
if strcmp(gui.retr('ui_mode'),'basic')
	gui.apply_ui_mode('basic');
end