%% Getting files
dataset='CalCOFI_data';
%feature_path="C:\Users\houli\OneDrive - UC San Diego\IFCB_data\"+ string(dataset) +"\features_withclass\class2022_v1\";
feature_path='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/'+ string(dataset) +"/features_withclass/class2022_v1/";
feature_bins=dir(fullfile(feature_path, 'D*'));

% Diatom=array2table(zeros(0,7),'VariableNames',variables);
% Dino=array2table(zeros(0,7),'VariableNames',variables);
% PN=array2table(zeros(0,7),'VariableNames',variables);
% Chae=array2table(zeros(0,7),'VariableNames',variables);
% All=array2table(zeros(0,7),'VariableNames',variables);

% 1-diatom, 2-dinoflagellate, 3-PN, 4-chaetoceracea, 5-total
% name[year,month,day,hour (UTC)], number of cells, sum of biovolumn, mean of biovolumn

%%

%%
Thourly=array2table(zeros(0,10),'VariableNames',{'Class','filename','Year','Month','Day','Hour','numCells','SumBiovol','MeanBiovol','MeanPMTB'});
%Tdaily=array2table(zeros(0,7),'VariableNames',{'Class','Year','Month','Day','numCells','SumBiovol','MeanBiovol'});

for i=1:length(feature_bins)
    T=readtable(feature_path+feature_bins(i).name);
    fname=feature_bins(i).name;
    T.class=categorical(T.class);T.class_above_threshold=categorical(T.class_above_threshold);
    dino=T(ismember(T.class,{'Akawishiwo','Ceratium','Dinoflagellate','Dinophysis','Dino sp1','Gonyaulacaceae',...
        'Gymnodiniales','Gyrodinium','Gymnodinium','Oxytoxum','Prorocentrum','Torodinium','phyto flagella sp'}),:);
    diatom=T(ismember(T.class,{'Bacteriastrum','Centric','Cerataulina','Chaetoceros','Chaetocerotaceae+Navicular','Cylindrotheca',...
        'Detonula','Eucampia','Guinardia','Hemiaulus','Lauderia','Leptocylindrus','Navicula','Pennate',...
        'Pseudo-nitzschia','Rhizosoleniaceae','Thalassionema'}),:);
    pn=T(T.class=='Pseudo-nitzschia',:); chae=T(ismember(T.class,{'Chaetoceros','Bacteriastrum'}),:);
    
    date={fname(1:24),fname(2:5),fname(6:7),fname(8:9),fname(11:12)};
    

    % diatom
%     Diatom=[Diatom;[date,{height(diatom),sum(diatom.Biovolume),mean(diatom.Biovolume)}]];
%     %dino
%     Dino=[Dino;[date,{height(dino),sum(dino.Biovolume),mean(dino.Biovolume)}]];
%     %PN
%     PN=[PN;[date,{height(pn),sum(pn.Biovolume),mean(pn.Biovolume)}]];
%     %Chae
%     Chae=[Chae;[date,{height(chae),sum(chae.Biovolume),mean(chae.Biovolume)}]];
%     %total
%     All=[All;[date,{height(T),sum(T.Biovolume),mean(T.Biovolume)}]];

    Thourly=[Thourly;[{'Diatoms'},date,{height(diatom),sum(diatom.Biovolume),mean(diatom.Biovolume),mean(diatom.PMTB)}];
       [{'Dino'},date,{height(dino),sum(dino.Biovolume),mean(dino.Biovolume),mean(dino.PMTB)}];
       [{'PN'},date,{height(pn),sum(pn.Biovolume),mean(pn.Biovolume),mean(pn.PMTB)}];
       [{'Chae'},date,{height(chae),sum(chae.Biovolume),mean(chae.Biovolume),mean(chae.PMTB)}];
       [{'All'},date,{height(T),sum(T.Biovolume),mean(T.Biovolume),mean(T.PMTB)}]];

end
disp('finishing creating tables')
%%
% savepath="C:\Users\houli\OneDrive - UC San Diego\IFCB_data\CalCOFI_data\manual\summary\";
savepath='/Users/houlin/Library/CloudStorage/OneDrive-UCSanDiego/IFCB_data/CalCOFI_underway/manual/';
writetable(Thour,string(savepath)+'CalCOFIunderway_hour_08Aug2023.csv')
disp('Saved results to '+string(savepath))
%% create new table based on groups of times

Thour=array2table(zeros(0,7),'VariableNames',{'Class','Day','Hour','numCells','SumBiovol','MeanBiovol','MeanPMTB'});
Thourly.group=string(Thourly.Class)+string(Thourly.Day)+string(Thourly.Hour);
groupname=unique(Thourly.group);

for i=1:length(groupname)
    group=groupname(i);
    subset=Thourly(strcmp(Thourly.group,group),1:8);
    subset=removevars(subset, 'filename');
    %subset=removevars(subset, 'Hour');
    Thour=[Thour;[subset.Class(1),subset.Day(1),subset.Hour(1),...
        nansum(subset.numCells),nansum(subset.SumBiovol),...
        nansum(subset.MeanBiovol.*subset.numCells)/nansum(subset.numCells),...
         nansum(subset.MeanPMTB.*subset.numCells)/nansum(subset.numCells)]];
end
%%
T=Tday;
PN_day=T(strcmp(T.Class,"PN"),:);
Chae_day=T(strcmp(T.Class,"Chae"),:);
All_day=T(strcmp(T.Class,"All"),:);

%%

figure('Position',[300 100 900 600]);
%plot(Diatom_day.SumBiovol,'Linewidth',2)
% bar(categorical(Diatom_day.Day),Diatom_day.numCells)
hold on
%bar(categorical(Dino_day.Day),PN_day.MeanBiovol)
bar(categorical(Dino_day.Day),Chae_day.MeanBiovol)

legend('topright',{'PN','Chae'})


title('Number of Species in CalCOFI underway August','FontSize',20)
xlabel('Days In August','Fontsize',15)
ylabel('Biovols in uL^3','Fontsize',15)
%%
figure('Position',[300 100 900 600]);
%plot(Diatom_day.SumBiovol,'Linewidth',2)
% bar(categorical(Diatom_day.Day),Diatom_day.numCells)
date=categorical(Dino_day.Day);
%bar(categorical(Dino_day.Day),PN_day.MeanBiovol)
yyaxis left
plot(date,Diatom_day.numCells,'Linewidth',2)
ylabel('Diatom numCells','Fontsize',15)

yyaxis right
plot(date,PN_day.numCells,'Linewidth',2)
ylabel('PN numCells','Fontsize',15)

%legend('topright',{'PN','Chae'})

title('Number of Species in CalCOFI underway August','FontSize',20)
xlabel('Days In August','Fontsize',15)

%%
