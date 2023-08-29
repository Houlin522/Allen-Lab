% CREATE  a location file

location=readtable("C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\IFCB_location.csv");
feature_path='C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\features\2022\';
feature_bins=dir(fullfile(feature_path, 'D*'));
featurenames={feature_bins(:).name}.';

T=table(featurenames,zeros(length(featurenames),1),zeros(length(featurenames),1),'VariableNames',{'filename','Lat','Lon'});

for i=1:height(location)
    T(contains(T.filename,location.filename(i)),2:3)={location.Lat(i),location.Lon(i)};
end
%% Map of the IFCB data
for i=1:height(CalCOFI_CTD)
    file_path=feature_path+string(featurenames{i});
    features=readtable(string(file_path));
    CalCOFI_CTD(i,4)={height(features)};
end    

disp('finished')
%%
y=T.Lon;
x=1:length(y);
y0=y(y~=0);
x0=find(y~=0);
yinter=interp1(x0,y0,x,"linear");
T.L=yinter.';
%%
% for i=1:height(T)
%     fname=char(T.filename(i));
%  
%     T.filename(i)={fname(1:24)};
% end
%%
% savepath="C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\";
% writetable(T,savepath+'CalCOFI_data_completed.csv')
% disp('Saved results to '+savepath)

Tloc=readtable('/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/CalCOFI_underway_location_completed.csv');
%%
diatom_table=Thourly(strcmp(Thourly.Class,'Diatoms'),:);
diatom_table=diatom_table(1:123,:);

%% create geographical map

%T=CalCOFI_CTD;
colormapValues=jet(length(Diatom.numCells));
figure('Position',[300 100 1000 600]);
ax=geoaxes;

% numCells, SumBiovol, MeanBiovol
%geoscatter(ax,Tloc.Lat,Tloc.Lon,Diatom.numCells,'filled')
geoscatter(ax,Tloc.Lat,Tloc.Lon,80,Diatom.numCells./All.numCells,'filled')
colormap(ax,colormapValues);
caxis([0 0.2])
colorbar;

title('Percentage Diatom from  CalCOFI Underway August','Fontsize',20)
% xlabel('Latitude','Fontsize',15)
% ylabel('Longtitude','Fontsize',15)

%% create different bars on figures 

figure;
bar3(T.Lon,T.Lat,diatom_table.MeanPMTB);
xlabel('Longitude');
ylabel('Latitude');
zlabel('Value');
title('3D Bar Plot on Map');
view(-45, 30);
grid on;
colorbar;
colormap('jet');
set(gca, 'XTickLabelRotation', 45);
set(gcf, 'Position', [100, 100, 800, 600]);
set(gcf, 'Resize', 'on');

%%
Diatom=Thourly(strcmp(Thourly.Class,'Diatoms'),:);
All=Thourly(strcmp(Thourly.Class,'All'),:);