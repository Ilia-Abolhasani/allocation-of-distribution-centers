clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration=400;
AN4P='AIA';% Algorithm name for Parameter
Ans_AIA=zeros(28,Average);
%% Loop
for i=1:28    
    disp(['AIA ' num2str(i) ' :']);
    for j=1:Average 
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_AIA(i,j)=Algorithm_AIA(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3));
    end    
end
%% Save
clearvars -except Ans_AIA
save('./Data/AIA.mat');