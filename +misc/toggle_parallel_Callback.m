function toggle_parallel_Callback(~, ~, ~)
hgui=getappdata(0,'hgui');
handles=gui.gethand;
load (fullfile('images','icons.mat'))
if gui.retr('darkmode')
	parallel_on=1-parallel_on+35/255;
	parallel_off=1-parallel_off+35/255;
	parallel_on(parallel_on>1)=1;
	parallel_off(parallel_off>1)=1;
end
try
	parallel=gui.retr('parallel');
	if parallel==0
		gui.put ('parallel',1);
		gui.toolsavailable(0,'请稍候，正在打开并行池...')
		pause(0.1)
		try
            c = parcluster("Processes");
             %use matlab suggested num of cores
			desired_num_cores=c.NumWorkers;
		catch
			desired_num_cores=feature('numCores');
		end
		misc.pivparpool('close')
		misc.pivparpool('open',desired_num_cores)
		set(handles.toggle_parallel, 'cdata',parallel_on,'TooltipString','并行处理已开启。点击关闭。');
	else
		gui.put ('parallel',0);
		gui.toolsavailable(0,'请稍候，正在关闭并行池...')
		misc.pivparpool('close')
		set(handles.toggle_parallel, 'cdata',parallel_off,'TooltipString','并行处理已关闭。点击开启。');
	end
	gui.toolsavailable(1);
catch ME
	gui.put ('parallel',0);
	set(handles.toggle_parallel, 'cdata',parallel_off,'enable','off', 'TooltipString','并行处理不可用。');
	gui.toolsavailable(1);
	disp (ME.message)
end

if gui.retr('parallel')==0
	set (handles.text_parallelpatches,'visible','off')
	set (handles.ofv_parallelpatches,'visible','off')
	set (handles.ofv_parallelpatches,'Value',1)
else
	set (handles.text_parallelpatches,'visible','on')
	set (handles.ofv_parallelpatches,'visible','on')
	set (handles.ofv_parallelpatches,'Value',6)
end