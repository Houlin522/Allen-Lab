%% set path and name
dataset='CalCOFI_data';
feature_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +"/features_withclass/class2022_v1/";
feature_bins=dir(fullfile(feature_path, 'D*'));

image_path='/Users/houlin/Desktop/PN_training/';
dest='/Users/houlin/Desktop/PN_training/PN_images/';
image_bins=dir(fullfile(image_path, 'D*'));

%%
classtable = array2table(classlist);
% Default heading for the columns will be A1, A2 and so on. 
% You can assign the specific headings to your table in the following manner
classtable.Properties.VariableNames(1:3) = {'roi_number','class','xxx'};
pn=classtable(classtable.class==28,:);

%% using manual classification
for i=1:length(image_bins)
    current=image_path+string(image_bins(i).name);
    images=dir(fullfile(current,'D*'));
    
    pn_roi=pn.roi_number;
    for x=1:length(pn_roi)
        n = pn_roi(x) ;                     % Stored or entered by user.
        ind = sprintf( '%05d', n ) ;
        image_name=string(image_bins(i).name)+'_'+string(ind)+'.png';
        movefile(string(current)+'/'+string(image_name), dest);
    end  
end
%% getting from class feature files 
for i=1:length(image_bins)
    current=image_path+string(image_bins(i).name);
    feature_name=string(image_bins(i).name)+ '_fea_v2 _withclass.csv';
    T=readtable(feature_path+feature_name);
    images=dir(fullfile(current,'D*'));
    
    T.class=categorical(T.class);
    T.class_above_threshold=categorical(T.class_above_threshold);
    pn=T(T.class_above_threshold=='Pseudo-nitzschia',:);
    
    pn_roi=pn.roi_number;
    for x=1:length(pn_roi)
        n = pn_roi(x) ;                     % Stored or entered by user.
        ind = sprintf( '%05d', n ) ;
        image_name=string(image_bins(i).name)+'_'+string(ind)+'.png';
        movefile(current+'/PN_images/'+image_name, image_path);
    end  
end
%%