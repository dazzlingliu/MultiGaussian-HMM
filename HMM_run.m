clear
dbstop if error
% superparameters
rep = 1;
figdisplay = 1;

options = struct();
options.subN = 30;
options.subT = 1000;
options.T = options.subT*ones(options.subN,1);
options.D = 40;
options.K = 4;
options.cycmax = 20;
outputdir = [cd '/Result/'];
if ~exist(outputdir,'file')
    mkdir(outputdir);
end

%%
% input
finput = load('simdataTBnC40-0.1noi1000tp30sub.mat');
%finput = load('sub100_ROI90_200tp_Signals_LR.mat');
Y = finput.simTC(1:options.subN*options.subT,1:options.D);%T*D
Y = zscoreY(Y,options);

for r = 1:rep
clear ModPara gamma LL
disp(['----------------rep = ',num2str(r),'---------------']);
% initial 
ModPara = initPara(options);
%train
[ModPara,gamma] = hmmTrainModel(Y,ModPara,options);
% display results
Modperf = struct();
[assig,Modperf.stateCorr,Modperf.gammaCorr] = ResultDisplay(ModPara,gamma,options,figdisplay); 
resname = [outputdir,'rep-',num2str(r),'.mat'];
%save(resname,'ModPara','gamma','Modperf','LL','options');
end
