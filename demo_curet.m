clear all;
close all;

addpath(genpath('classification_toolbox_4.0'))
rootpath = '/Users/ahmedtaha/Documents/MATLAB/Datasets/curetcol/sample'
patch_width = -1;patch_height = -1;
training_Dataset = [];

no_classes = 3;
no_training_classes = 2;
training_classes = [1,4,6,10,12,14,16,18,20,22,25,27,30,33,35,41,45,48,50,59];
total_images_per_class = 92;
training_per_class = 46;
test_per_class = total_images_per_class-training_per_class;

RFS = makeRFSfilters;
filter_bank = RFS;
training_options = 'MR8';
classification_options = 'MR8';

numOfFilters = size(filter_bank,3);
if strfind(training_options, 'MR8')
    numOfFilters =8;
end


KNN = 1;


numClustersPerClass = 10;
NUM_BINS = numClustersPerClass * no_classes;

total_images = cell(total_images_per_class,no_training_classes);


%classes = [2,3,5,7,8,9,15,17,19,21,24,36,37,39,43,44,47,52,54,58];         
for c=1:no_training_classes
    i = training_classes(c); 
    folderPath = [rootpath sprintf('%02d',i) '/'];
    filenames = [fuf(folderPath ,'detail')]; 
    total_images(1:total_images_per_class,c) = filenames(1:total_images_per_class ,:);
    %training_images(1:training_per_class ,c) = filenames(1:training_per_class ,:);
    %test_images(1:test_per_class,c) = filenames(training_per_class+1:total_images_per_class,:);
    
    %training_images(1:training_per_class ,c) = filenames(1:2:total_images_per_class ,:);
    %test_images(1:test_per_class,c) = filenames(2:2:total_images_per_class,:);
end





params = {};
params.numOfFilters = numOfFilters;
params.numClustersPerClass = numClustersPerClass;
params.no_training_classes = no_training_classes;
params.patch_width = patch_width;
params.patch_height = patch_height;
params.filter_bank = filter_bank;
params.training_options = training_options;
params.total_images_per_class = total_images_per_class;
params.total_images = total_images;

[ training_class_centroid ] = build_texton_dictionary( params );



classes = 1:no_classes;
training_images = cell(training_per_class,no_classes);
test_images = cell(test_per_class,no_classes);
total_images = cell(total_images_per_class,no_classes);
for c=1:no_classes
    i = classes(c); 
    folderPath = [rootpath sprintf('%02d',i) '/'];
    filenames = [fuf(folderPath ,'detail')]; 
    total_images(1:total_images_per_class,c) = filenames(1:total_images_per_class ,:);
    
    %% Taking all images
    %training_images(1:training_per_class ,c) = filenames(1:training_per_class ,:);
    %test_images(1:test_per_class,c) = filenames(training_per_class+1:total_images_per_class,:);
    
    %% Alternative images
    %training_images(1:training_per_class ,c) = filenames(1:2:total_images_per_class ,:);
    %test_images(1:test_per_class,c) = filenames(2:2:total_images_per_class,:);
    
    perm = randperm(total_images_per_class);
    sel = perm(1:training_per_class);
    %% Random Images
    training_images(1:training_per_class ,c) = filenames(sel);
    test_images(1:test_per_class,c) = filenames(setdiff(1:total_images_per_class,sel));
end




params = {};
params.patch_width = patch_width;
params.patch_height = patch_height;
params.filter_bank = filter_bank;
params.training_options = training_options;
params.training_images = training_images;
params.training_class_centroid = training_class_centroid;
params.NUM_BINS = NUM_BINS;
params.training_per_class = training_per_class;
params.no_classes = no_classes;

[ training_histogram,training_classes ] = build_histogram_models( params);


params = {};
params.patch_width = patch_width;
params.patch_height = patch_height;
params.filter_bank = filter_bank;
params.classification_options = classification_options;
params.training_class_centroid = training_class_centroid;
params.NUM_BINS = NUM_BINS;
params.no_classes = no_classes;
params.training_histogram = training_histogram;
params.training_classes = training_classes;
params.test_images = test_images;
params.test_per_class = test_per_class;
params.KNN = KNN;
[test_histogram,test_classes, accuracy ] = classify_images( params );



figure;imagesc(accuracy);
mean(diag(accuracy) * 100 / test_per_class)
per_class_accuracy = diag(accuracy) * 100 / test_per_class;