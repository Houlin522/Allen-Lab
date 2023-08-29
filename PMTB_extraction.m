function []=PMTB_extraction(in_dir_base)
%in_dir_base='C:\Users\houli\OneDrive - UC San Diego\IFCB\PlumesBlooms_data\data\2021\';
daydir = dir(string(in_dir_base) + 'D*');
daydir = daydir([daydir.isdir]); 
bins = [];
in_dir = [];
out_dir_blob = [];
for ii = 1:length(daydir)
    in_dir_temp = strjoin([in_dir_base daydir(ii).name filesep],'');
    bins_temp = dir(strjoin([in_dir_temp '*.adc'],''));
    myfolder=bins_temp(1).folder;
    ds=tabularTextDatastore(myfolder,"FileExtensions",".adc");
    writeall(ds,in_dir_base)
end
fprintf('Extracting PMTB ')
end
