%% Tuning_Harmony
%A : HMS, B : HMCR, C = PAR, D : X_MAX, E : X_MIN
% 5 parameter , 5*5

clear
clc
%% Add path & Address manage
addpath('../.');
AddPaths('.././','allocation4DC');
%% Data
MaxIteration=1000;
AvrageNumber=4;

HMS=[5 ,10 ,15];
HMCR=[0.9 , 0.99 ,0.999];
PAR=[0.001,0.01,0.1];
%X_MAX=[0.8 , 0.85 , 0.9 , 0.95 , 1];
%X_MIN=[0 , 0.05 , 0.1 , 0.15 , 0.2];

Table=[1	1	1
1	2	2
1	3	3
2	1	2
2	2	3
2	3	1
3	1	3
3	2	1
3	3	2];
Ans=zeros(size(Table,1),28);
tic
%% Loop
for k=1:size(Table,1)
    for i=1:28
        Avrage=zeros(1,AvrageNumber);
        for j=1:AvrageNumber
            Avrage(1,j)=Algorithm_HS(Finalmodel(i),MaxIteration,HMS(Table(k,1)),HMCR(Table(k,2)),PAR(Table(k,3)),0,1);
        end
        clc
        Ans(k,i)=mean(Avrage)
    end
end
clc
Ans=RPD(Ans,1);
Ans=mean(Ans,2)
MEPFM(Ans,Table);
toc
beep