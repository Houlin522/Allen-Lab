function T=findmissingfiles(file_path,feature_dir)% Set the path to the Downloads folder
%% apple  path
%features_dir='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI underway/features/';


%% window desktop  path
%downloadsPath = fullfile('/Users/houli/Downloads');
%file_path='/Users/houli/OneDrive - UC San Diego/IFCB_data/Stearns Wharf/data/2022';
%features_dir="/Users/houli/OneDrive - UC San Diego/IFCB_data/Stearns Wharf/features";

%% Get a list of all files in the Downloads folder
filesfolder = dir(file_path+'*D2022*');
featureslist= dir(feature_dir+'D*');
%%

T  = cell2table(cell(0,3), 'VariableNames', {'filename', 'count', 'type'});
%%
% Loop through each file in the Downloads folder
for i = 1 :length(filesfolder)
    filelist=dir(fullfile(filesfolder(i).folder, filesfolder(i).name,'*IFCB*'));
    
    for ii =1:length(filelist)
        fullname=filelist(ii).name;
        filename=fullname(1:16);
        filetype=fullname(length(fullname)-3:length(fullname));
        if ~ ismember( filename, T.filename )  
             Tnew=array2table({filename,1,filetype}, 'VariableNames', {'filename', 'count', 'type'});
             T=[T;Tnew];
        else
            T.count(string(T.filename)==filename)={cell2mat(T.count(string(T.filename)==filename))+1};
            T.type(string(T.filename)==filename)={string(T.type(string(T.filename)==filename))+filetype};
        end 
    end
end

%loop through features



for ii =1:length(featureslist)
    fullname=featureslist(ii).name;
    filename=fullname(1:16);
    filetype=fullname(length(fullname)-3:length(fullname));
    if ~ ismember( filename, T.filename )  
         Tnew=array2table({filename,1,filetype}, 'VariableNames', {'filename', 'count', 'type'});
         T=[T;Tnew];
    else
        T.count(string(T.filename)==filename)={cell2mat(T.count(string(T.filename)==filename))+1};
        T.type(string(T.filename)==filename)={string(T.type(string(T.filename)==filename))+filetype};
    end 
end

%%
missingT=T(cell2mat(T.count)<4,:);
writetable(missingT,'missingvalues_aug.csv')
fprintf('find '+string(height(missingT))+' missing files and write missingvalues.csv');
end
%%
