% table 5
clc;
clear all;
close all;

%% SA
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_SA(Finalmodel((i-1)*4+j),Parameter(1,1),Parameter(1,2),Parameter(1,3),Parameter(1,4));
   
        AverageTime(j,i)=toc;
    end
end
Ans_SA=mean(AverageCost);
Ans_SA_Time=mean(AverageTime);
%% GA
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_GA(Finalmodel((i-1)*4+j),Parameter(2,1),Parameter(2,2),Parameter(2,3),Parameter(2,4),Parameter(2,5),Parameter(2,6));
        AverageTime(j,i)=toc;
    end
end
Ans_GA=mean(AverageCost);
Ans_GA_Time=mean(AverageTime);
%% KA
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_KA(Finalmodel((i-1)*4+j),Parameter(3,1),Parameter(3,2),Parameter(3,3),Parameter(3,4),Parameter(3,5));
        AverageTime(j,i)=toc;
    end
end
Ans_KA=mean(AverageCost);
Ans_KA_Time=mean(AverageTime);
%% AIA
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_AIA(Finalmodel((i-1)*4+j),Parameter(4,1),Parameter(4,2),Parameter(4,3),Parameter(4,4));
        AverageTime(j,i)=toc;
    end
end
Ans_AIA=mean(AverageCost);
Ans_AIA_Time=mean(AverageTime);
%% PSO
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_PSO(Finalmodel((i-1)*4+j),Parameter(5,1),Parameter(5,2),Parameter(5,3),Parameter(5,4),Parameter(5,5),Parameter(5,6));
        AverageTime(j,i)=toc;
    end
end
Ans_PSO=mean(AverageCost);
Ans_PSO_Time=mean(AverageTime);
%% HS
AverageTime=zeros(4,7);
AverageCost=zeros(4,7);
for i=1:7
    for j=1:4
        tic
        AverageCost(j,i)=Algorithm_HS(Finalmodel((i-1)*4+j),Parameter(6,1),Parameter(6,2),Parameter(6,3),Parameter(6,4),Parameter(6,5),Parameter(6,6));
        AverageTime(j,i)=toc;
    end
end
Ans_HS=mean(AverageCost);
Ans_HS_Time=mean(AverageTime);
%% RPD Anses
% Ans_SA=
% Ans_GA=
% Ans_KA=
% Ans_AIA=
% Ans_PSO=
% Ans_Harmony=
%% Result
plot(Ans_SA,Ans_SA_Time,...
    Ans_GA,Ans_GA_Time,...
    Ans_KA,Ans_KA_Time,...
    Ans_AIA,Ans_AIA_Time...
    ,Ans_PSO,Ans_PSO_Time...
    ,Ans_HS,Ans_HS_Time);

