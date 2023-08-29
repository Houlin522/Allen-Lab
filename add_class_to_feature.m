function []=add_class_to_feature(feature_path,output_path,class_path)
% the function allows to add PMTB to the feature files
%the file path should include the years
%feature_path='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\features\2021\';
%output_path='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\features_withclass\class2021_v1\';
%class_path='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\class\class2021_v1\';
feature_bins = dir(strjoin([feature_path 'D*'],''));
class_daydir=dir(strjoin([class_path 'D*'],''));

if ~exist(output_path, 'dir')
    mkdir(output_path)
end

for ii = 1 :length(class_daydir)
    class_bins= load(strjoin([class_path class_daydir(ii).name],''));
    class=class_bins.TBclass;
    class_above_threshold=class_bins.TBclass_above_threshold;
    date=extractBefore(class_daydir(ii).name,"_IFCB");
    fname=extractfield(feature_bins,'name');
    oldfeature=fname(contains(fname,date));
    str=oldfeature{1};
    newstr=insertAfter(str,"v2"," _withclass");
    newfeature=readtable(strjoin([feature_path oldfeature{1}],''));
    newfeature.class= class_bins.TBclass;
    newfeature.class_above_threshold=class_bins.TBclass_above_threshold;
    writetable(newfeature,strjoin([output_path newstr],''))
    
end
disp('finishing adding classes to features')
end

