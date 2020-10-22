clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration=400;
AN4P='SA';% Algorithm name for Parameter
Ans_SA=zeros(28,Average);
%% Loop
for i=1:28
    disp(['Sa ' num2str(i) ' :']);
    for j=1:Average
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_SA(i,j)=Algorithm_SA(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3));
    end
end
%% Save
clearvars -except Ans_SA
save('./Data/SA.mat');