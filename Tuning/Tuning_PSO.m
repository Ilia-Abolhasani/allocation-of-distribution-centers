%% Tuning PSO
%A : Nparticle , B : d , C : c0 , D : c1 , E : c2
% 5 parameter , 5*5

clear all
clc
%% Add path & Address manage
addpath('../.');
AddPaths('.././','allocation4DC');

%% Data
MaxIteration=1000;
AvrageNumber=4;

Nparticle=[20, 30, 40];
d=[0.9, 0.99, 0.999];
c0=[0.8, 0.9, 1];
c1=[1.2, 1.6, 1.9];
c2=[2, 2.5, 2.9];

Table=[1	1	1	1	1
1	1	1	1	2
1	1	1	1	3
1	2	2	2	1
1	2	2	2	2
1	2	2	2	3
1	3	3	3	1
1	3	3	3	2
1	3	3	3	3
2	1	2	3	1
2	1	2	3	2
2	1	2	3	3
2	2	3	1	1
2	2	3	1	2
2	2	3	1	3
2	3	1	2	1
2	3	1	2	2
2	3	1	2	3
3	1	3	2	1
3	1	3	2	2
3	1	3	2	3
3	2	1	3	1
3	2	1	3	2
3	2	1	3	3
3	3	2	1	1
3	3	2	1	2
3	3	2	1	3];
Ans=zeros(size(Table,1),28);
tic
%% Loop
for k=1:size(Table,1)
    for i=1:28
        Avrage=zeros(1,AvrageNumber);
        for j=1:AvrageNumber
            Avrage(1,j) =Algorithm_PSO(Finalmodel(i),MaxIteration,Nparticle(Table(k,1)),d(Table(k,2)),c0(Table(k,3)),c1(Table(k,4)),c2(Table(k,5)));
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