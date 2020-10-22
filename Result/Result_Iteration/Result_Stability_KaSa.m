clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration_KA=400;
Iteration_SA=25;
AN4P='KaSa';% Algorithm name for Parameter
Ans_KaSa=zeros(28,Average);
%% Loop
for i=1:28
    disp(['KaSa ' num2str(i) ' :']);
    for j=1:Average
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_KaSa(i,j)=Algorithm_Hybrid_KaSa(Finalmodel(i),Iteration_KA,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Iteration_SA,Parameter(AN4P,5),Parameter(AN4P,6));
    end
end
%% Save
clearvars -except Ans_KaSa
save('./Data/KaSa.mat');