function pivlabmanual_Callback(~, ~, ~)
try
	web('https://www.pivlab.de/manual/','-browser')
catch
	%why does 'web' not work in v 7.1.0.246 ...?
	disp('哎呀，MATLAB 无法打开网站。')
	disp('您需要手动打开网站：')
	disp('https://www.pivlab.de/manual/')
end
