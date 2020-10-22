%% Tuning_SA
% A : T0 , B : Alpha
% 2 parameter , 2*3

close all;
clear all;
clc;
%% Add path & Address manage
addpath('../.');
AddPaths('.././','allocation4DC');

%% Data
MaxIteration=1;
AvrageNumber=1;

T0=[1000, 1200, 1500];
Alpha=[0.9, 0.99, 0.999];
MutationIndex=[1 , 2 , 3 , 4 , 5];
Table=[1	1	1
1	2	2
1	3	3
2	1	1
2	2	2
2	3	3
3	1	2
3	2	3
3	3	1
4	1	3
4	2	1
4	3	2
5	1	2
5	2	3
5	3	1
1	1	3
3	2	1
5	3	2];
Ans=zeros(size(Table,1),28);
tic
%% Loop
for k=1:size(Table,1)
    for i=1:28
        Avrage=zeros(1,AvrageNumber);
        for j=1:AvrageNumber
            Avrage(1,j)=Algorithm_SA(Finalmodel(i),MaxIteration,T0(Table(k,2)),Alpha(Table(k,3)),MutationIndex(Table(k,1)));
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