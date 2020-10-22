clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration=400;
AN4P='HS';% Algorithm name for Parameter
Ans_HS=zeros(28,Average);
%% Loop
for i=1:28    
    disp(['HS ' num2str(i) ' :']);
    for j=1:Average 
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_HS(i,j)=Algorithm_HS(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Parameter(AN4P,5));
    end      
end
%% Save
clearvars -except Ans_HS
save('./Data/HS.mat');