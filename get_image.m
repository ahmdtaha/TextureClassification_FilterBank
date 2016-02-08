function [ im ] = get_image( image_path ,patch_width,patch_height,options)


im = imread(image_path);

if(size(im,3)>1)
    im =double(rgb2gray(im));
else
    im =double(im);
end


if(patch_width ~= -1)
    row_index = round((size(im,1)-patch_width)/2);
    col_index = round((size(im,2)-patch_height)/2);
    im = im(row_index:row_index+patch_width-1,col_index:col_index+patch_height-1);
end

im_mean = mean(im(:));
im_std = std(im(:));
im = im - im_mean;
im = im / im_std;

end

