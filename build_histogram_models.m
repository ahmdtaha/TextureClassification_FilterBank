function [ training_histogram,training_classes ] = build_histogram_models( params)

patch_width = params.patch_width;
patch_height = params.patch_height;
filter_bank = params.filter_bank;
training_options = params.training_options;
training_images = params.training_images;
training_class_centroid = params.training_class_centroid;
NUM_BINS = params.NUM_BINS;
training_per_class = params.training_per_class;
no_classes = params.no_classes;

training_histogram = zeros(training_per_class*no_classes,NUM_BINS);
training_classes = zeros(training_per_class*no_classes,1);

for i=1:no_classes
    
    fprintf('Start: Building Histogram for class %d\n',i);
    for j=1:training_per_class
        image_name = training_images{j,i};
        
        filter_response = im2filter_response( image_name,patch_width,patch_height,filter_bank,training_options);
        histogram= filter_respone2histogram( filter_response,training_class_centroid,NUM_BINS);
        
        index = j+ (i-1)*training_per_class;
        training_histogram(index,:) = histogram;
        training_classes(index,:) = i;
        %training_histogram(train_index ,:) = histogram;
        %training_classes(train_index ,:) = i;
        %train_index  = train_index + 1;
    end
    fprintf('End: Building Histogram for class %d\n',i);
end


end

