clear all
clc
% Define the folder containing the TIFF images
folderPath = 'D:\PIV Data\pco_edge'; % Replace with your folder path

% Define the file pattern for the TIFF images
filePattern = fullfile(folderPath, 'PIVlab_pco*.tif');
%filePattern = fullfile(folderPath, 'PIVlab_0*_A.tif');

% Get a list of all TIFF files matching the pattern
imageFiles = dir(filePattern);
amount_imgs=0;
for i=1:numel(imageFiles)
	iminfo=imfinfo(fullfile(folderPath,imageFiles(i).name));
	amount_imgs=amount_imgs+size(iminfo,1);
end

idx=1;
timing_chart=zeros(amount_imgs,1);
img_no=zeros(amount_imgs,1);
for i=1:numel(imageFiles)
	disp(['Image file no ' num2str(i) ' of ' num2str(numel(imageFiles))])
	imgs_per_file=imfinfo(fullfile(folderPath,imageFiles(i).name));
	imgs_per_file=size(imgs_per_file,1);
	for k=1:imgs_per_file
		image=imread(fullfile(folderPath,imageFiles(i).name),k,'PixelRegion',{[1 2],[1 100]});
		if any(image(1,:) > 1023) %manche Bilder werden nach wie vor LSB gespeichert, obwohl MSB eingestellt ist... :(
        image=uint16(image/64);
        end
        %image=bitshift(image,-4);
		timestamps = image(1, 1:14);
		timestamps = bitand(timestamps, 15) + bitshift(timestamps, -4) * 10;
		ts = struct();
		ts.image_number = sum(timestamps(:, 1:4) .* [uint16(1e6), uint16(1e4), uint16(1e2), uint16(1)], 2, 'native');
		ts.year = sum(timestamps(:, 5:6) .* [uint16(1e2), uint16(1)], 2, 'native');
		ts.month = uint32(timestamps(:, 7));
		ts.day = uint32(timestamps(:, 8));
		ts.microseconds = sum(uint64(timestamps(:, 9:14)) .* uint64([(3600e6), (60e6), (1e6), (1e4), (1e2), (1)]), 2, 'native');
		timing_chart(idx)=ts.microseconds;
		img_no(idx) = ts.image_number;
		idx=idx+1;
	end
end

timing_chart=timing_chart-timing_chart(1);
timing_chart=double(timing_chart/1000/1000);
capture_freq=1./diff(timing_chart,1);
figure;
plot(capture_freq)


figure;
plot((img_no));



