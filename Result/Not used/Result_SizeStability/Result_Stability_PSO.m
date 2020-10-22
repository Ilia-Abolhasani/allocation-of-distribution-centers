clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=6;
Iteration=1000;
AN4P='PSO';% Algorithm name for Parameter
TempAns=zeros(28,1);
AverageCost=zeros(Average,1);
%% Loop
clc
for i=1:28    
      disp(['PSO ' num2str(i) ' :']);
    for j=1:Average
         disp([num2str(i) ' . ' num2str(j)]);
        AverageCost(j,1)=Algorithm_PSO(Finalmodel(i),Iteration,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Parameter(AN4P,5));
    end 
    TempAns(i,1)=mean(RPD(AverageCost,1),1);
end
%% Create Ans
Ans=zeros(7,1);
for i=1:7
    N=(i-1)*4+1;
    Ans(i,1)=mean(TempAns(N:N+3));    
end
%% Save
clearvars -except Ans
save('./Data/PSO.mat');