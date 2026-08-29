function pco_error_msgbox
filepath = fileparts(which('PIVlab_GUI.m'));
gui.custom_msgbox('error',getappdata(0,'hgui'),'未找到 pco.matlab',['未找到 pco.matlab 扩展。' newline  '您需要安装 pco.matlab，然后将该文件夹永久添加到 Matlab 搜索路径中。' newline newline '请遵循 github 上 wiki 中的说明： ' newline newline 'https://github.com/Shrediquette/PIVlab/wiki/Setup-pco-cameras'],'modal');


