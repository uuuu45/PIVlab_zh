function save_imgs_Callback(~, ~, ~)
gen_image_1=gui.retr('gen_image_1');
gen_image_2=gui.retr('gen_image_2');
real_displacement_u=gui.retr('real_displ_u');
real_displacement_v=gui.retr('real_displ_v');
if isempty(gen_image_1)==0
	[FileName,PathName] = uiputfile('*.tif','将生成的图像保存为...',['PIVlab_gen.tif']);
	if isequal(FileName,0) | isequal(PathName,0)
	else
		[Dir, Name, Ext] = fileparts(FileName);
		FileName_1=[Name '_01' Ext];
		FileName_2=[Name '_02' Ext];
		if exist(fullfile(PathName,FileName_1),'file') >0 || exist(fullfile(PathName,FileName_2),'file') >0
			butt = gui.custom_msgbox('quest',getappdata(0,'hgui'),'文件已存在',['警告：文件 ' FileName_1 ' 已存在。'],'modal',{'覆盖','取消'},'覆盖');
			if strncmp(butt, '覆盖',2) == 1
				write_it=1;
			else
				write_it=0;
			end
		else
			write_it=1;
		end
		if write_it==1
			imwrite(gen_image_1,fullfile(PathName,FileName_1),'Compression','none')
			imwrite(gen_image_2,fullfile(PathName,FileName_2),'Compression','none')
			save(fullfile(PathName,[Name '_real_displacement.mat']) ,'real_displacement_u','real_displacement_v')
		end
	end
end

