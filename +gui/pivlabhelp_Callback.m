function pivlabhelp_Callback(~, ~, ~)
try
	web('https://shrediquette.github.io/PIVlab/wiki/1-quickstart/','-browser')
catch
	%why does 'web' not work in v 7.1.0.246 ...?
	disp('哎呀，MATLAB 无法打开网站。')
	disp('您需要手动打开网站：')
	disp('https://shrediquette.github.io/PIVlab/wiki/1-quickstart/')
end

