function FetchPylon()
%gui.update_progress(0)
answer = gui.custom_msgbox('quest',getappdata(0,'hgui'),'未找到相机',['无法检测到 OPTOcam。' newline '下载并安装 OPTOcam 驱动？'],'modal',{'是','否'},'是');
switch answer
	case '是'
		%gui.toolsavailable(1)
		%gui.toolsavailable(0,'Downloading OPTOcam driver...');drawnow
		FileName = 'pylon.exe';
		FilePath=userpath;
		weburl='https://docs.pivlab.de/pylon.exe';
		%ME=download_stuff(weburl,FileName,FilePath)
		
		
		
		%[ME]=fetchOutputs(F)

		fig = uifigure;
		fig.Visible='off';
		fig.Position = [680   687   444   191];
		movegui(fig,'center');
		fig.Resize='off';
		fig.WindowStyle = 'modal';
		fig.Visible='on';
		d = uiprogressdlg(fig,'Title','请稍候','Message','正在下载 OPTOcam 驱动','Cancelable','on');
		F = parfeval(backgroundPool,@download_stuff,1,weburl,FileName,FilePath);
		progress=0;
		cancelled=0;
		while strcmpi (F.State, 'running')
			s = dir(fullfile(FilePath,FileName));
			if ~isempty(s)
				filesize = s.bytes;
				progress= (filesize/1028320736);
				d.Value=progress;
				d.Message = ['正在下载 OPTOcam 驱动（' num2str(round(filesize/1024/1024)) ' / ' num2str(round(1028320736/1024/1024)) ' MB）。'];
			end
			if d.CancelRequested
				cancel(F)
				cancelled=1;
				break
			end
			pause(0.25)
		end
		close(d)
		close(fig)

		%% install drivers
		%gui.toolsavailable(1)
		if cancelled==0
			%   gui.toolsavailable(0,'Installing...');drawnow
			disp('reboots two times the computer....!')
			system([fullfile(FilePath,FileName) ' /passive /uninstall'])
			system([fullfile(FilePath,FileName) ' /passive /install=USB_Runtime;USB_Camera_Driver;GenTL_Producer_USB;GenTL_Consumer_Support'])
		end
		delete(fullfile(FilePath,FileName))
		% gui.toolsavailable(1)
	case '否'
end


function [ME]=download_stuff (weburl,FileName,FilePath)
ME=[];
try
websave(fullfile(FilePath,FileName),weburl);
catch ME
end


%try
%	mget(ftpobj,FileName,FilePath);

%catch ME
%end
%pause(1)
%close(ftpobj)
%clearvars('ftpobj')