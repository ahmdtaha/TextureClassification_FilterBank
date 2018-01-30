function [ filter_response ] = im2filter_response( image_name,patch_width,patch_height,filter,options)

%image_name
training_im = get_image(image_name,patch_width,patch_height,options);

filter_response = zeros(size(training_im,1)*size(training_im,2),size(filter,3));
for k=1:size(filter,3)
    tmp = conv2(double(training_im ),filter(:,:,k),'same');
    filter_response(:,k)=tmp(:);
end;
if strfind(options, 'MR8')
    filter_response_MR8 = zeros(size(training_im,1)*size(training_im,2),8);
    
    % pick the *absolute* maximum response
    filter_response_MR8(:,1) = max(abs(filter_response(:,1:6)),[],2);
    filter_response_MR8(:,2) = max(abs(filter_response(:,7:12)),[],2);
    filter_response_MR8(:,3) = max(abs(filter_response(:,13:18)),[],2);
    filter_response_MR8(:,4) = max(abs(filter_response(:,19:24)),[],2);
    filter_response_MR8(:,5) = max(abs(filter_response(:,25:30)),[],2);
    filter_response_MR8(:,6) = max(abs(filter_response(:,31:36)),[],2);
    
    filter_response_MR8(:,7:8) = filter_response(:,37:38);
    filter_response = filter_response_MR8;
end
L = sum(filter_response' .^2)';
L = sqrt(L);
sc = log(1 + L / 0.03);
numerator = bsxfun(@times,filter_response,sc);
filter_response = bsxfun(@rdivide,numerator,L);


end

