function result=check_project_path(projectpath,caller)
handles=gui.gethand;
result=0;
if ~exist(projectpath,'dir')
	button = gui.custom_msgbox('quest',getappdata(0,'hgui'),'创建？','文件夹不存在。创建？','modal',{'是','取消'},'是');
	if strmatch(button,'是')==1
		mkdir(projectpath);
		result=1;
		acquisition.update_ac_status(['已创建文件夹 ' projectpath]);
	end
else
	result=1;
end
if strcmp(caller,'double_images')
	if result==1
		pcofilePattern = fullfile(projectpath, 'PIVlab_pco*.tif');
		direc= dir(pcofilePattern);
		if ~isempty(direc)
			direc=fullfile(projectpath,direc(1).name);
		else
			direc='';
		end
		if exist(fullfile(projectpath,'PIVlab_0000_A.tif'),'file')==2 || exist(fullfile(projectpath,'frame_000001.tiff'),'file')==2 || exist(direc,'file')==2
			button = gui.custom_msgbox('quest',getappdata(0,'hgui'),'覆盖？','覆盖文件？','modal',{'是','取消'},'是');
			if strmatch(button,'是')==1
				result=1;
			else
				result=0;
			end
		end
	end
end

