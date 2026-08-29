clc
close all
clear all
delete(imaqfind);
imaqreset

% Setup
buffers = 100;
frame_rate=1000; %this needs to be adjusted manually in this prototype, only the synchronizer and PIVlab know the frequency.

bitmode=10
if bitmode==8
exposure=1/frame_rate*1000^2-3;
else
    exposure=1/frame_rate*1000^2-5;
end
bfml_dir  = 'C:\Users\thiel\Documents\MATLAB\PIVlab_source\PIVlab_capture_resources';
camfilemode='CalibrationMode10bit'; %funktioniert ohne Fehler
%camfilemode='PIVMode8bit'; % funktioniert ohne Fehlermeldung, timing + dropped frames nicht kontrolliert.
camfilemode='PIVMode10bit'; %gibt am Ende Fehlermeldung, dass keine buffers availble.... Außerdem kommen Daten mit 300 Hz statt mit Kameraframerate. Interframe scheint aber zu stimmen... Gehen Daten mit 1000 Hz in framegrabber, und dann mit 300 Hz in RAM?
%es könnte sein, dass die Daten im ringbuffer überschrieben werden.
bfml_path = fullfile(bfml_dir, [camfilemode '@' 'Optronis-Cyclone-2-2000-M_OLT.bfml']);
%OPTRONIS_vid = videoinput('bitflow', 1, [bfml_path ';BuffersToUse=' num2str(buffers/2)]); %works for 8 bit, but not for 10 bit
OPTRONIS_vid = videoinput('bitflow', 1, [bfml_path ';BuffersToUse=' num2str(buffers*8)]); % I can only get this working each time without error, when I multiply by 16 compared to 8 bit...?!?
disp('10 bit works when I increase buffers by a factor of 16 compared to 8 bit.')

OPTRONIS_src = OPTRONIS_vid.Source;

OPTRONIS_src.BFGTLNodeName = 'ExposureTime'; %this needs to be set as it is very individual.
OPTRONIS_src.BFGTLNodeValueStr = num2str(round(exposure));
%OPTRONIS_src.BFGTLNodeName = 'AcquisitionFrameRate'; %this needs to be set as it is very individual. But probably only during synced capture...?
%OPTRONIS_src.BFGTLNodeValueStr = '100';

%{
% Configure camera
% I will set as much as possible via the camera file. So most of this isnt necessary. Just exposure time needs to be set.
OPTRONIS_src.BFGTLNodeName = 'PixelFormat';
OPTRONIS_src.BFGTLNodeValueStr = 'Mono8';
OPTRONIS_src.BFGTLNodeName = 'AcquisitionMode';
OPTRONIS_src.BFGTLNodeValueStr = 'Continuous';
OPTRONIS_src.BFGTLNodeName = 'ExposureMode';
OPTRONIS_src.BFGTLNodeValueStr = 'Timed';
%}
OPTRONIS_src.BFGTLNodeName = 'CounterInformation';
OPTRONIS_src.BFGTLNodeValueStr = 'On';

% Configure MATLAB to capture exactly  frames in one burst
OPTRONIS_vid.FramesPerTrigger = buffers;
OPTRONIS_vid.TriggerRepeat = 0;

% Verify buffers
%assert(OPTRONIS_src.BuffersAllocated == buffers, 'Buffer allocation failed!');




%% Set ROI
%ROI_OPTRONIS=[ROI_OPTRONIS(1)-1, ROI_OPTRONIS(2)-1, ROI_OPTRONIS(3), ROI_OPTRONIS(4)];
%ROI_OPTRONIS(3) = max(64, floor(ROI_OPTRONIS(3)/64)*64); % width must be multiple of 64 (4 CXP links × 16-pixel quantum)
OPTRONIS_src.BFGTLNodeName     = 'OffsetX'; % zero offsets before changing size to avoid constraint violations
OPTRONIS_src.BFGTLNodeValueStr = '0';
OPTRONIS_src.BFGTLNodeName     = 'OffsetY';
OPTRONIS_src.BFGTLNodeValueStr = '0';
OPTRONIS_src.BFGTLNodeName     = 'Width';
OPTRONIS_src.BFGTLNodeValueStr = num2str(1920);
OPTRONIS_src.BFGTLNodeName     = 'Height';
OPTRONIS_src.BFGTLNodeValueStr = num2str(1080);

%% "Pre-warming acquisition, so that first external trigger is really accepted...
 disp('prewarm start')
        % Pre-warm: 2 frames with internal trigger (Continuous mode), discard
        % Ensures the CXP/DMA pipeline and camera state machine are fully initialised
        % before the real triggered acquisition, preventing the first-frame skip.
        OPTRONIS_src.BFGTLNodeName     = 'AcquisitionStop';   % put camera in Idle (makes AcquisitionMode writable)
        OPTRONIS_src.BFGTLNodeValueStr = '1';                 % '1' executes a GenICam command node
        OPTRONIS_src.BFGTLNodeName     = 'AcquisitionMode';
        OPTRONIS_src.BFGTLNodeValueStr = 'Continuous';
        OPTRONIS_vid.FramesPerTrigger  = 2;
        triggerconfig(OPTRONIS_vid, 'immediate');
        start(OPTRONIS_vid);
        wait(OPTRONIS_vid, 5);             % 2 frames @ 100 fps = 20 ms; 5 s is a safe ceiling
        stop(OPTRONIS_vid);                % sends AcquisitionStop -> camera back to Idle
        flushdata(OPTRONIS_vid);           % discard warm-up frames

        % Restore SingleFrame + external trigger for the real acquisition
        OPTRONIS_src.BFGTLNodeName     = 'AcquisitionMode';
        OPTRONIS_src.BFGTLNodeValueStr = 'SingleFrame';
        OPTRONIS_vid.FramesPerTrigger  = buffers;
        pause(0.1);
        disp('prewarm stop')

% GO!

preview(OPTRONIS_vid);



%% experiment
%OPTRONIS_vid.FramesAcquiredFcnCount = 10;  % trigger every n frames
%OPTRONIS_vid.FramesAcquiredFcn = {@frames_acquired_callback, buffers};
%OPTRONIS_vid.StopFcn = {@stop_callback};



start(OPTRONIS_vid);
start_acquisition=tic; %in case the acquisition starts immediately, save the starting time
cntr=1;
while cntr < buffers
    pause(0.01)
%while OPTRONIS_vid.FramesAvailable<buffers
    %estimate camera progress (not needed anymore with StopFCN
    %{
    if OPTRONIS_vid.FramesAvailable==0 % reset starting time as long as no frames have actually been captured
        start_acquisition=tic;
    end
    elapsed_camera_capture=toc(start_acquisition);
    if elapsed_camera_capture > (buffers/frame_rate + 1)
        disp('Camera capture done.')
    else
        disp(['elapsed capture time = ' num2str(elapsed_camera_capture)])
        pause(0.25)
    end
    %}
    %disp(num2str(OPTRONIS_vid.FramesAvailable))
    %frames_captured = OPTRONIS_vid.FramesAvailable;
    %pause(0.5)
    %approximate_fps=(OPTRONIS_vid.FramesAvailable-frames_captured)*2;
    %disp(['Transferring data with approximately ' num2str(approximate_fps) ' fps.'])



    %% Grab available frames
    %%{
    n_available = OPTRONIS_vid.FramesAvailable;
    if n_available == 0
        pause(0.01);
        continue;
    end
    if n_available > 200
        n_available = 200;
    end
    data = getdata(OPTRONIS_vid, n_available); %grab data from bitflow buffer on the fly
    if numel(data)>0
        disp('Writing block')
        for i= 1: size(data,4) %images are arranged like width,height,1,image_nr
            if bitmode==10 %scale data at lower 10 bits from 16bit image to upper 10 bits.
                imwrite(bitshift(data(:,:,1,i),6),['D:\PIV Data\delete\' sprintf('%5.5d',cntr-1) '.tif'],'Compression','none');
            else
                imwrite(data(:,:,1,i),['D:\PIV Data\delete\' sprintf('%5.5d',cntr-1) '.tif'],'Compression','none');
            end
            cntr=cntr+1;
            %anzahl gespeicherter Frames setzen
        end
        clear data
    end
    %%}
end

%data = getdata(OPTRONIS_vid); % blocks until all  frames are received
stop(OPTRONIS_vid);
stoppreview(OPTRONIS_vid)
closepreview(OPTRONIS_vid)

function stop_callback(OPTRONIS_vid, ~)
disp('Wenn While loop 100% ausgelastet, dann wird das hier leider nicht zum rechten zeitpunkt ausgeführt.')
disp('!!!!!!!!!!!!!! STOPPERLE !!!!!!!!!!!!!!!!!!!')
stoppreview(OPTRONIS_vid)
end

%% Define the callback function
function frames_acquired_callback(vid, event, buffers)
%wird alle 10 frames ausgelöst, speichert dann alles was da ist --> Nach dem ersten mal speichern ist viel Zeit verstrichen, und es ist ganz besonders viel datan da, die dann im zweiten durchlauf alle gespeichert werden.
n_available = vid.FramesAvailable;
if n_available == 0
    return;
end
%das geht nicht, callback wird nicht mehr aufgerufen
if n_available >100 
    n_available =100;
end

% Grab available frames
data = getdata(vid, n_available);

% Get current frame count from persistent variable
persistent frames_saved;
if isempty(frames_saved)
    frames_saved = 0;
end

% Save frames
for i = 1:size(data, 4)
    frame_num = frames_saved + i;
    imwrite(data(:,:,1,i), ...
        ['D:\PIV Data\delete\' sprintf('%5.5d',frame_num-1) '.tif'], ...
        'Compression', 'none');
end

frames_saved = frames_saved + n_available;
clear data;

fprintf('Callback: saved %d/%d frames\n', frames_saved, buffers);

% Reset persistent when done
if frames_saved >= buffers
    frames_saved = [];
end
end