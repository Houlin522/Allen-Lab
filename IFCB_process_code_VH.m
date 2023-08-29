
%% window's path
% dataset='CalCOFI_underway';
% in_dir_base='C:\Users\houli\OneDrive - UC San Diego\IFCB\'+ string(dataset) +'\data\2022\August_nofeatures';
% out_dir_blob_base='C:\Users\houli\OneDrive - UC San Diego\IFCB\'+ string(dataset) +'\blob\';
% out_dir_feature='C:\Users\houli\OneDrive - UC San Diego\IFCB\'+ string(dataset) +'\features\';
% parallel_proc_flag = false;

%% apple path

in_dir_base="/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/"+ string(dataset) +"/data/2022/nofeatures/";
out_dir_blob_base='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/blob/';
out_dir_feature='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features/';
parallel_proc_flag = false;

%% test blob and features
start_blob_batch_user_training(in_dir_base , out_dir_blob_base, parallel_proc_flag)
%%
start_feature_batch_user_training(in_dir_base , out_dir_blob_base, out_dir_feature, parallel_proc_flag)

%% add PMTB fluoresence measurement to features
in_dir_base='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\2022\October\';
feature_path='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\features\2022\';
%%
in_dir_base='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/data/2022/';
feature_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features/';

PMTB_extraction(in_dir_base)
add_PMTB_to_feature(feature_path,in_dir_base)

%% windows
% dataset='CalCOFI_underway';
% classifierName =  "C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\manual\summary\CalCOFI_Trees1_04Aug2023.mat"; %USER what classifier do you want to apply (full path)
% in_dir_feature = 'C:/Users/houli/OneDrive - UC San Diego/IFCB_data/'+ string(dataset) +'/features/'; %USER where are your feature files
% out_dir_class = 'C:/Users/houli/OneDrive - UC San Diego/IFCB_data/'+ string(dataset) +'/class/class2022_v1/';% USER what is the base path for output files
%% apple
dataset='CalCOFI_underway';
classifierName =  "/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_data/manual/summary/CalCOFI_Trees1_04Aug2023.mat"; %USER what classifier do you want to apply (full path)
in_dir_feature = '/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features/'; %USER where are your feature files
out_dir_class = '/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/class/class2022_v1/';% USER what is the base path for output files

%%
start_classify_batch_user_training(classifierName , in_dir_feature, out_dir_class)

%% summarize result
%window
% classpath='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\class\class2022_v1\';% USER what is the base path for output files
% in_dir='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\2022\';

% applepath
classpath='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/class/class2022_v1/';% USER what is the base path for output files
in_dir='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/data/2022/';

countcells_allTBnew_user_training(classpath,in_dir,2022)

%% add class to feature
% window
% feature_path='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\features\2022\';
% output_path='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\features_withclass\class2022_v1\';
% class_path='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\class\class2022_v1\';

% apple
feature_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features/';
output_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features_withclass/class2022_v1/';
class_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/class/class2022_v1/';


add_class_to_feature(feature_path,output_path,class_path)
%% window manully annotate images 
% manual_file='C:\Users\houli\OneDrive - UC San Diego\GitHub\ifcb-analysis\manualclassify\config\CalCOFI_window.mcconfig.mat';
% startMC(manual_file)

%% manully annotate images, apple
manual_file_apple='C:\Users\houlin\Library\CloudStorage\OneDrive-UCSanDiego\GitHub\ifcb-analysis\manualclassify\config\CalCOFI_apple.mcconfig.mat';
startMC(manual_file_apple)


%% get training features from pre-computed bin feature files
dataset='CalCOFI_data';
% manualpath = 'C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\manual\'; % manual annotation file location
% feapath_base = 'C:\Users\houli\OneDrive - UC San Diego\IFCB_data\'+ string(dataset) +'\features\'; %feature file location, assumes \yyyy\ organization
manualpath='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/manual/'; % apple manual annotation
feapath_base='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +'/features/';

maxn = 2000; %maximum number of images per class to include
minn = 30; %minimum number for inclusion
% Optional inputs;
% class2skip = {'
% other'}; % for multiple use: {'myclass1' 'myclass2'}
% class2skip = {}; %for case to skip none and include class2merge
% class2group = {{'class1a' 'class1b'} {'class2a' 'class2b' 'class2c'}}; %use nested cells for multiple groups of 2 or more classes
% startMC('default')
disp(manualpath)
compile_train_features_user_training(manualpath,feapath_base, maxn, minn)
%% create Random Forest classifier from training data
result_path = 'C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\manual\summary\'; %USER location of training file and classifier output
train_filename = 'UserExample_Train_04Aug2023.mat'; %USER what file contains your training features
result_str = 'CalCOFI_Trees1_';
nTrees = 150; %USER how many trees in your forest; choose enough to reach asymptotic error rate in "out-of-bag" classifications
make_TreeBaggerClassifier_user_training(result_path, train_filename, result_str, nTrees )

%% evaluating classifier
result_path = '/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_data/manual/summary/';
classifername=[result_path 'CalCOFI_Trees1_04Aug2023.mat'];
classifier_oob_analysis(classifername)

