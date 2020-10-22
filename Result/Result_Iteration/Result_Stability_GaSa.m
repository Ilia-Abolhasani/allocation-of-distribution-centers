clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=30;
Iteration_GA=400;
Iteration_SA=25;
AN4P='GaSa';% Algorithm name for Parameter
Ans_GaSa=zeros(28,Average);
%% Loop
for i=1:28    
    disp(['GaSa ' num2str(i) ' :']);
    for j=1:Average 
        disp([num2str(i) ' . ' num2str(j)]);
        Ans_GaSa(i,j)=Algorithm_Hybrid_GaSa(Finalmodel(i),Iteration_GA,Parameter(AN4P,1),Parameter(AN4P,2),Parameter(AN4P,3),Parameter(AN4P,4),Parameter(AN4P,5),Iteration_SA,Parameter(AN4P,6),Parameter(AN4P,7));
    end  
end
%% Save
clearvars -except Ans_GaSa
save('./Data/GaSa.mat');