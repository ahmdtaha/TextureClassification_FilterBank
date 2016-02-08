function [test_histogram,test_classes, accuracy ] = classify_images( params )


patch_width = params.patch_width;
patch_height = params.patch_height;
filter_bank = params.filter_bank;
training_class_centroid = params.training_class_centroid ;
NUM_BINS = params.NUM_BINS;
classification_options = params.classification_options;
no_classes = params.no_classes;
training_histogram = params.training_histogram;
training_classes = params.training_classes;
test_images = params.test_images;
test_per_class = params.test_per_class;
KNN = params.KNN;

test_histogram = zeros(test_per_class,NUM_BINS);
test_classes = zeros(test_per_class,1);

test_index = 1;
dist_type = 'chi';
pret_type = 'none';

accuracy = zeros(no_classes ,no_classes );
for i=1:no_classes
    fprintf('Start: Classification for class %d\n',i);
    for j=1:test_per_class 
        image_name = test_images{j,i};
        filter_response = im2filter_response( image_name,patch_width,patch_height,filter_bank,classification_options);
        histogram= filter_respone2histogram( filter_response,training_class_centroid,NUM_BINS);
    
        test_histogram(test_index,:) = histogram;
        test_classes(test_index,:) = i;
        test_index = test_index + 1;
        
        pred = knnpred(histogram',training_histogram,training_classes,KNN,dist_type,pret_type);
        
        
        accuracy(i,pred.class_pred) = accuracy(i,pred.class_pred) + 1;
    end
    fprintf('End: Classification for class %d\n',i);
end


end

