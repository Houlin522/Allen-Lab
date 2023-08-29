
in_dir_base='C:\Users\houli\OneDrive - UC San Diego\Desktop\IFCB\PlumesBlooms_data\features\2021\';
%% load data
ifcb_data = readtable([in_dir_base 'D20211013T152857_IFCB151_fea_v2.csv']);
ifcb_data1 = readtable([in_dir_base 'D20211013T163152_IFCB151_fea_v2.csv']);
ifcb_data2 = readtable([in_dir_base 'D20211013T165537_IFCB151_fea_v2.csv']);
mytable=[ifcb_data;ifcb_data1;ifcb_data2];
feature_data=mytable(:,2:end);
myclasslist=[classlist;classlist1;classlist2];
class=myclasslist(:,2);
%% spliting into test and training set
[m,n] = size(feature_data) ;
P = 0.70 ;
idx = randperm(m)  ;
X_Tr = feature_data(idx(1:round(P*m)),:) ; 
X_Test = feature_data(idx(round(P*m)+1:end),:) ;
y_tr=class(idx(1:round(P*m)));
y_test=class(idx(round(P*m)+1:end));
%% create a random forest classifier
%Tr is the training samples
% cl1 is the class label for the training images
%Ts is the testing samples
%cl2 is the class label for the test images 
nTrees=500;
maxn = 100; %maximum number of images per class to include
minn = 30; %minimum number for inclusion
simpletree = TreeBagger(nTrees,X_Tr,y_tr, 'Method', 'classification'); 

pred = simpletree.predict(X_Test);
pred = cellfun(@(x)str2double(x), pred);
accuracy=sum(pred==y_test)/length(y_test);