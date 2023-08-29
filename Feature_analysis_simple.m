feature_path="C:\Users\houli\OneDrive - UC San Diego\IFCB_data\PlumesBlooms_data\features\2021\";
feature_bins=dir(fullfile(feature_path, 'D*'));
for i=1 %:length(feature_bins)
    feature=readtable(feature_path+feature_bins(i).name);
end

Area=feature{:,"Area"};
Biovolume=feature{:,"Biovolume"};
Fluorescent=feature{:,'PMTB'};
%% scatter plot
scatter(Biovolume, Area,'filled')
xlabel('Cell Volumn')
ylabel('Area')

%% histogram
h=histogram(Biovolume);