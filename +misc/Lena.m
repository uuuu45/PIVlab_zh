function Lena
MainWindow=getappdata(0,'hgui');
if strncmp (char(datetime('today')),'15-Oct',6)
	yr=char(datetime('today'));
	since=str2num(yr(8:11))-2005;
	gui.custom_msgbox('quest',getappdata(0,'hgui'),'今天是 10 月 15 日！',['爱 Lena 已有 ' num2str(since) ' 年！'],'modal',{'恭喜！'},'恭喜！');
	set(MainWindow, 'Name','今天是 Lena 日！！')
end

