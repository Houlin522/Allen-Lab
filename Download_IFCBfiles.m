
%% downloading files using py file



%% moving download files

%apple download path
downloadsPath = fullfile('/Users/houlin/Downloads'); % apple
feature_dir='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/features';
output_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/data/2022/August';

% window desktop download path
%downloadsPath = fullfile('/Users/houli/Downloads');
%output_path='/Users/houli/OneDrive - UC San Diego/IFCB_data/Stearns Wharf/data/2022';
%output_dir="/Users/houli/OneDrive - UC San Diego/IFCB_data/Stearns Wharf/features";

moving_downloadfiles(downloadsPath,feature_dir,output_path)
%% find missing files
file_path="/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/data/2022/August/";
feature_dir="/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/features/";
T=findmissingfiles(file_path,feature_dir);

%% moving files with no features to no features
file_path="/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/data/2022/August/";
file_nofeature="/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/data/2022/nofeatures/";
