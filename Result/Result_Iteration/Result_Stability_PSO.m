clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration=400;
AN4P='PSO';% Algorithm name for Parameter
Ans_PSO=zeros(28,Average);
%% Loop
for i=1:28    
      disp(['PSO ' num2str(i) ' :']);
    for j=1:Average
         disp([num2str(i) ' . ' num2str(j)]);
        Ans_PSO(i,j)=Algorithm_PSO(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Parameter(AN4P,5));
    end 
end
%% Save
clearvars -except Ans_PSO
save('./Data/PSO.mat');