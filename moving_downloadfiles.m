function []=moving_downloadfiles(downloadsPath,output_dir,output_path)

% Find all files with "feature" in the name in the Downloads folder
feature_fileList = dir(fullfile(downloadsPath, '*feature*'));
% Check if the "feature" folder already exists in the current directory

%
if exist(output_dir, 'dir')
    fprintf('Found existing "features" folder.\n');
else
    % If not, create it
    mkdir(output_dir);
    fprintf('Created new "features" folder.\n');
end
% Loop through each file in the list and move it to the "feature" folder
for i = 1:length(feature_fileList)
    filename = feature_fileList(i).name;
    if ~contains(filename,'(1)')
        filepath = fullfile(feature_fileList(i).folder, filename);
        movefile(filepath, output_dir);
    end
    
end
fprintf('Move all feature file to Features');

%%
% Get a list of all files in the Downloads folder
files = dir(fullfile(downloadsPath, '*IFCB*'));
% Loop through each file in the Downloads folder
for i = 1:length(files)
    
    if ~files(i).isdir && length(files(i).name)>24 && ~contains(files(i).name ,'(1)')
        % Extract the first 9 characters of the file's name
        first9Chars = files(i).name(1:9);
        
        % Construct the path of the folder that has the same first 9 characters
        folderPath = fullfile(output_path, first9Chars);
        
        % Create the folder if it does not exist
        if ~exist(folderPath, 'dir')
            mkdir(folderPath);
        end
        
        % Construct the path of the destination file
        destFile = fullfile(folderPath, files(i).name);
        filepath=fullfile(downloadsPath, files(i).name);
        % Move the file to the destination folder
        movefile(filepath, destFile);
    end
end

fprintf('Move all file to destination file');
end
