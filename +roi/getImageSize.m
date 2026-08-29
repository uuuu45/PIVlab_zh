function imagesize = getImageSize()
% Return the known image dimensions, recovering them from the displayed image if needed.
imagesize = gui.retr('expected_image_size');

if isnumeric(imagesize) && numel(imagesize) >= 2 && ...
		all(isfinite(imagesize(1:2))) && all(imagesize(1:2) > 0)
	imagesize = double(imagesize(1:2));
	return
end

imagesize = [];
try
	pivlab_axis = gui.retr('pivlab_axis');
	image_handle = findobj(pivlab_axis, 'Type', 'image');
	if isempty(image_handle)
		return
	end

	image_data = get(image_handle(1), 'CData');
	image_size = size(image_data);
	if numel(image_size) >= 2 && all(image_size(1:2) > 0)
		imagesize = double(image_size(1:2));
		gui.put('expected_image_size', imagesize);
	end
catch
	% No displayed image is available from which to recover the ROI bounds.
	imagesize = [];
end
