%% Tuning_GA
%A :Npop  , B : PCrossover  , C : PMutation
% 3 parameter , 3*3 

close all;
clear all;
clc;
%% Add path & Address manage
addpath('../.');
AddPaths('.././','allocation4DC');

%% Data
MaxIteration=1000;
AvrageNumber=4;

Npop=[80, 100, 120];
PCrossover=[0.9, 0.945, 0.99];
PMutation=[0.03, 0.06, 0.08];
CrossoverType=[1 , 2 , 3];
MutationType=[1 , 2 , 3 , 4 , 5];

Table=[1	1	1	1	1
1	2	2	2	2
1	3	3	3	3
2	1	1	2	2
2	2	2	3	3
2	3	3	1	1
3	1	2	1	3
3	2	3	2	1
3	3	1	3	2
4	1	3	3	2
4	2	1	1	3
4	3	2	2	1
5	1	2	3	1
5	2	3	1	2
5	3	1	2	3
5	1	3	2	3
4	2	1	3	1
3	3	2	1	2];

Ans=zeros(size(Table,1),28);
tic
%% Loop
for k=1:size(Table,1)
    for i=1:28
        Avrage=zeros(1,AvrageNumber);
        for j=1:AvrageNumber            
            Avrage(1,j)=Algorithm_GA(Finalmodel(i),MaxIteration,Npop(Table(k,2)),PCrossover(Table(k,3)),PMutation(Table(k,4)),CrossoverType(Table(k,5)),MutationType(Table(k,1)));
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