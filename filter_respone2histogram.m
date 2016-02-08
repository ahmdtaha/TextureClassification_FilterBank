function [ histogram   ] = filter_respone2histogram( filter_response,training_class_centroid,NUM_BINS)
    image_size = size(filter_response,1);
    
    texton_map = zeros(image_size ,1);
    
    hist_start = 1;
    bins_ranges = hist_start:NUM_BINS ;
    
    for k=1:image_size 
        pixel = filter_response(k,:);
        [~, assign] = min(vl_alldist(pixel', training_class_centroid'));
        texton_map(k) = assign; 
    end
    %figure;imagesc(reshape(texton_map,patch_height,patch_width));
    histogram  = histc(texton_map,bins_ranges);
    %% Normalize
    histogram  = histogram ./ sum(histogram);
    %max_v = max(histogram)
    %sum_v = sum(histogram)
    %histogram  = histogram ./ max(histogram);
    %figure;bar(histogram);
end

