function no_dongle_msgbox
gui.custom_msgbox('error',getappdata(0,'hgui'),'无法连接',['未找到与 PIVlab-SimpleSync 的连接。' sprintf('\n') 'USB 加密狗是否已连接？'],'modal');


