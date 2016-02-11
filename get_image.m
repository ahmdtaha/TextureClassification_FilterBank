function [ im ] = get_image( image_path ,patch_width,patch_height,options)
%% get_image , will load the image from image_path
%           - patch_width,patch_height can be used to crop certain part of an
%           image. 
%           If you want to load the whole image, set these values to -1
%           
%           - options can be used to pass extra parameters, like applying a
%           particular transformation to the image after being loaded

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

