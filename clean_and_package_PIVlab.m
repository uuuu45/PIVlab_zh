clc
%% Run tests
cd('unittests');[testResults,coverageResults] = runtests;

cd ('C:\Users\thiel\Documents\MATLAB\PIVlab_source')
pause(3) %user can see test results

%% Cleaning the settings
clear
try
    rmpref('PIVlab_ad','enable_ad')
catch
end
try
    rmpref('PIVlab_ad','video_warn')
catch
end

load ('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_capture_resources\PIVlab_capture_lensconfig.mat');
selected_lens_config_nr = 4; %set default to OPTOcam
lens_configurations("Pitch_Offset",2) = {0};
lens_configurations("Roll_Offset",2) = {0};

save ('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_capture_resources\PIVlab_capture_lensconfig.mat','lens_configurations','selected_lens_config_nr');
clear

try
    rmdir('C:\Users\thiel\Documents\MATLAB\PIVlab_source\+wOFV\Filter matrices\', 's')
catch
    disp('Filter matrices directory does not exist')
end

try
    rmdir('C:\Users\thiel\Documents\MATLAB\PIVlab_source\Toolbox', 's')
catch
    disp('old Toolbox directory does not exist')
end
try
    rmdir('C:\Users\thiel\Documents\MATLAB\PIVlab_source\Standalone', 's')
catch
    disp('old Standalone directory does not exist')
end
load('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_settings_default.mat');
clear homedir
clear pathname
clear ac_ROI_general
clear Chronos_IP
clear last_selected_device
clear last_selected_fps
clear selected_com_port
build_date= datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss');
stereomode=0; %set default to stereomode=off;
save('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_settings_default.mat');
warning off
delete ('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_capture_resources\laser_device_id.mat');
delete ('C:\Users\thiel\Documents\MATLAB\PIVlab_source\+plot\fastLICFunction.mexw64')
%warning on
clear
disp('OK') 

%% get version no
A=fileread('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_GUI.m');
idx=findstr('version = ''',A); 
version=string(A(idx+11:idx+14));

%% package toolbox
disp('New files in exisitng folders seem to be added automatically. But for the App, the folders have to be added in this script.')
opts=matlab.addons.toolbox.ToolboxOptions('C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_source.prj');
opts.ToolboxVersion = version;
matlab.addons.toolbox.packageToolbox(opts)


%% package stand alone
disp('New files in exisitng folders seem to be added automatically')
projectRoot = "C:\Users\thiel\Documents\MATLAB\PIVlab_source";
% Create target build options object, set build properties and build.
buildOpts = compiler.build.StandaloneApplicationOptions(fullfile(projectRoot, "PIVlab_GUI.m"));
buildOpts.AdditionalFiles = [fullfile(projectRoot, "+acquisition"), fullfile(projectRoot, "+calibrate"), fullfile(projectRoot, "+export"), fullfile(projectRoot, "+extract"), fullfile(projectRoot, "+gui"), fullfile(projectRoot, "+gui", "corr_demo.mlapp"), fullfile(projectRoot, "+import"), fullfile(projectRoot, "+mask"), fullfile(projectRoot, "+misc"), fullfile(projectRoot, "+piv"), fullfile(projectRoot, "+plot"), fullfile(projectRoot, "+postproc"), fullfile(projectRoot, "+preproc"), fullfile(projectRoot, "+roi"), fullfile(projectRoot, "+simulate"), fullfile(projectRoot, "+validate"), fullfile(projectRoot, "+wOFV"), fullfile(projectRoot, "+wOFV", "FD matrices"), fullfile(projectRoot, "+wOFV", "OptimizationSolvers"), fullfile(projectRoot, "Example_data"), fullfile(projectRoot, "OptimizationSolvers"), fullfile(projectRoot, "PIVlab_capture_resources"), fullfile(projectRoot, "PIVlab_capture_resources", "pco_resources"), fullfile(projectRoot, "PIVlab_capture_resources", "tycmd.exe"), fullfile(projectRoot, "PIVlab_settings_default.mat"), fullfile(projectRoot, "help"), fullfile(projectRoot, "images"), fullfile(projectRoot, "+opencv"), fullfile(projectRoot, "PIVlab_capture_resources", "bitflow_resources","R2024b"), fullfile(projectRoot, "PIVlab_capture_resources", "bitflow_resources","R2025b"), fullfile(projectRoot, "PIVlab_capture_resources", "bitflow_resources","R2026a"), fullfile(projectRoot, "PIVlab_hidden_elements.txt")];
buildOpts.AutoDetectDataFiles = true;
buildOpts.OutputDir = fullfile(projectRoot, "Standalone", "build");
buildOpts.SupportPackages = {"GenICam Interface","USB Webcams"};
buildOpts.ObfuscateArchive = false;
buildOpts.Verbose = true;
buildOpts.EmbedArchive = true;
buildOpts.ExecutableIcon = fullfile(projectRoot, "images", "appicon.png");
buildOpts.ExecutableName = "PIVlab";
buildOpts.ExecutableSplashScreen = fullfile(projectRoot, "images", "pivlab_standalone_splashscreen.png");
buildOpts.ExecutableVersion = version;
buildOpts.TreatInputsAsNumeric = false;
buildResult = compiler.build.standaloneApplication(buildOpts);

%compiler.runtime.customInstaller('yesyesyes', buildResult,RuntimeDelivery="installer") %verstehe den Sinn nicht... Macht auch nur eine kleine exe die das ganze runtime herunterlädt.

% Create package options object, set package properties and package.
packageOpts = compiler.package.InstallerOptions(buildResult);
packageOpts.ApplicationName = "PIVlab";
packageOpts.AuthorName = "William Thielicke";
packageOpts.AuthorEmail = "thielicke@optolution.com";
packageOpts.AuthorCompany = "OPTOLUTION Messtechnik GmbH";
packageOpts.DefaultInstallationDir = "%ProgramFiles%/PIVlab";
packageOpts.Description = "PIVlab is a free and open-source particle image velocimetry (PIV) software and is currently the most frequently cited PIV tool on the market. It can be used to calculate the velocity distribution within imported (or captured) images. It can also control OPTOLUTION's lasers, cameras and synchronizers, and derive, display and export multiple parameters of the flow pattern. The simple graphical user interface makes PIV data acquisition and data post-processing fast and efficient.";
packageOpts.InstallerIcon = fullfile(projectRoot, "images", "appicon.png");
packageOpts.InstallerLogo = fullfile(projectRoot, "images", "pivlab_standalone_installerscreen.png");
packageOpts.InstallerName = "PIVlab_installer";
packageOpts.InstallerSplash = fullfile(projectRoot, "images", "pivlab_standalone_splashscreen_3.jpg");
packageOpts.InstallationNotes = "Have fun and good luck with your research!";
packageOpts.OutputDir = fullfile(projectRoot, "Standalone", "package");
packageOpts.Summary = "Easy to use, GUI based tool to capture, analyze, validate, postprocess, visualize and simulate PIV data." + newline + "http://PIVlab.de";
packageOpts.Verbose = true;
packageOpts.Version = version;
compiler.package.installer(buildResult, "Options", packageOpts);


%% Upload file version identifier via FTP
answer = questdlg('Upload new file version to thielicke.org server?', 'Upload?','Yes', 'No','Yes');
if strcmp(answer,'Yes')
	opts.windowstlye = 'modal';
	answer = inputdlg('Please enter highlighted feature here','Starred feature of the release',1,{'New: '},opts);
	answer=answer{1};
	writematrix(answer,'starred_feature.txt');
	update_file_name='latest_version.txt';
	writematrix(version,update_file_name)
	copyfile 'latest_version.txt' 'latest_version_p.txt'
	copyfile 'latest_version.txt' 'latest_version_standalone.txt'
	copyfile 'latest_version.txt' 'latest_version_william.txt'
	ftpobj = ftp('shared03.keymachine.de','ftp_kh_27973_1','!Sesamstrasse-11');
	cd(ftpobj,'PIVlab');
	mput(ftpobj,fullfile(pwd, update_file_name));
	mput(ftpobj,fullfile(pwd, 'latest_version_p.txt'));
	mput(ftpobj,fullfile(pwd, 'latest_version_standalone.txt'));
	mput(ftpobj,fullfile(pwd, 'latest_version_william.txt'));
	mput(ftpobj,fullfile(pwd, 'starred_feature.txt'));

	close(ftpobj);
	fprintf('Version file contents:')
	type(update_file_name)
	type('starred_feature.txt')
	delete(update_file_name)
	delete('starred_feature.txt');
	delete('latest_version_p.txt')
	delete('latest_version_standalone.txt')
	delete('latest_version_william.txt')
end

winopen('C:\Users\thiel\Documents\MATLAB\PIVlab_source\Standalone\package\');
winopen('C:\Users\thiel\Documents\MATLAB\PIVlab_source\toolbox\');

%disp('Change version number in PIVlab_GUI.m, Toolbox and App.')
disp('ToDo: Github neues Release machen und dann anhängen: PIVlab.mltbx und PIVlab_installer.exe aus Toolbox und Standalone Folder')
