function [ training_class_centroid ] = build_texton_dictionary( params )

numOfFilters = params.numOfFilters;
numClustersPerClass = params.numClustersPerClass;
no_training_classes = params.no_training_classes;
patch_width = params.patch_width;
patch_height = params.patch_height;
filter_bank = params.filter_bank;
training_options = params.training_options;
total_images_per_class = params.total_images_per_class;
total_images = params.total_images;

training_class_centroid = zeros(numClustersPerClass * no_training_classes,numOfFilters);
for i=1:no_training_classes
   
    training_filter_response = [];
    fprintf('Start: training class %d\n',i);
    perm = randperm(total_images_per_class);
    sel = perm(1:13);
    for j=1:13
        image_name = total_images{sel(j),i};
        filter_response = im2filter_response( image_name,patch_width,patch_height,filter_bank,training_options);
        training_filter_response = [training_filter_response;filter_response]; 
    end
    
    start = (i-1)*numClustersPerClass+1;
    count = numClustersPerClass-1;
    
    
    [centers, ~] = vl_kmeans(training_filter_response', numClustersPerClass);
    training_class_centroid(start:start+count,:) = centers';
    
    %opts = statset('MaxIter',200);
    %[assignments,centers] = kmeans(training_filter_response, numClustersPerClass,'Options',opts,'Replicates',2);
    %training_class_centroid(start:start+count,:) = centers;
    
 
    fprintf('End: training class %d\n',i);
end

end

