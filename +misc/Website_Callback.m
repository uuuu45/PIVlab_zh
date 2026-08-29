function Website_Callback(~, ~, ~)
try
	web('http://pivlab.de/','-browser')
catch
	%why does 'web' not work in v 7.1.0.246 ...?
	disp('哎呀，MATLAB 无法打开网站。')
	disp('您需要手动打开网站：')
	disp('http://PIVlab.de/')
end

