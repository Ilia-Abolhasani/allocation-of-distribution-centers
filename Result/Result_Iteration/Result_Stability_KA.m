clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration=400;
AN4P='KA';% Algorithm name for Parameter
Ans_KA=zeros(28,Average);
%% Loop
disp(['KA ' num2str(i) ' :']);
for i=1:28    
    for j=1:Average 
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_KA(i,j)=Algorithm_KA(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4));
    end      
end
%% Save
clearvars -except Ans_KA
save('./Data/KA.mat');