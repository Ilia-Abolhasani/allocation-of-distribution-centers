clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=1;
Iteration_KA=500;
Iteration_SA=100;
AN4P='KaSa';% Algorithm name for Parameter
TempAns=zeros(28,1);
AverageCost=zeros(Average,1);
%% Loop
for i=1:28    
    disp(['KaSa ' num2str(i) ' :']);
    for j=1:Average         
        AverageCost(j,1)=Algorithm_Hybrid_KaSa(Finalmodel(i),Iteration_KA,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Iteration,Parameter(AN4P,5),Iteration_SA,Parameter(AN4P,6));
    end  
    TempAns(i,1)=mean(AverageCost,1);
end
%% Create Ans
Ans=zeros(7,1);
for i=1:7
    N=(i-1)*4+1;
    Ans(i,1)=mean(TempAns(N:N+3));    
end
%% Save
clearvars -except Ans
save('./Data/KaSa.mat');