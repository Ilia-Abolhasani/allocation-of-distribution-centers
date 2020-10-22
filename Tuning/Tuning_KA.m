%% Tuning_Keshtel
% A : Nkeshtel , B : Smax , C : p1 , D : p2
% 4 parameter , 4*4

clear all;
clc
%% Add path & Address manage
addpath('../.');
AddPaths('.././','allocation4DC');

%% Data
MaxIteration=1000;
AvrageNumber=4;

Nkeshtel=[150 , 250 , 350];
Smax=[15 , 25 ,35];
p1=[0.1, 0.2 , 0.3];
p2=[0.2 , 0.3 , 0.4];

Table=[1	1	1	1
1	2	2	2
1	3	3	3
2	1	2	3
2	2	3	1
2	3	1	2
3	1	3	2
3	2	1	3
3	3	2	1];
Ans=zeros(size(Table,1),28);
tic
%% Loop
for k=1:size(Table,1)
    for i=1:28
        Avrage=zeros(1,AvrageNumber);
        for j=1:AvrageNumber
            Avrage(1,j)=Algorithm_KA(Finalmodel(i),MaxIteration,Nkeshtel(Table(k,1)),Smax(Table(k,2)),p1(Table(k,3)),p2(Table(k,4)));
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