% add the PMTB measurement to the feature files 
function []=add_PMTB_to_feature(feature_path,PMTB_path)
% the function allows to add PMTB to the feature files
%the file path should include the years
%feature_path='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\features\2021\';
%PMTB_path='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\data\2021\';
feature_bins = dir(strjoin([feature_path 'D*'],''));
PMTB_daydir=dir(strjoin([PMTB_path 'D*'],''));
for ii = 1:length(PMTB_daydir)
    PMTB_temp= strjoin([PMTB_path PMTB_daydir(ii).name filesep],'');
    PMTB_bins=dir(strjoin([PMTB_temp '*.txt'],''));
    for i=1:length(PMTB_bins)
        PMTB_name=PMTB_bins(i).name;
        T=readtable(strjoin([PMTB_temp PMTB_bins(i).name],''));
        PMTB_value=T{:,'Var4'};
        date=extractBefore(PMTB_name,"_IFCB");
        fname=extractfield(feature_bins,'name');
        oldfeature=fname(contains(fname,date));
        newfeature=readtable(strjoin([feature_path oldfeature{1}],''));
        valid_PMTB= PMTB_value(newfeature.roi_number);
        newfeature.PMTB= valid_PMTB;
        writetable(newfeature,strjoin([feature_path oldfeature{1}],''))
    end
end
fprintf('finished adding PMTB to feature')
end