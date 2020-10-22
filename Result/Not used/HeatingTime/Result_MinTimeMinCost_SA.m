clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
AN4P='SA';% Algorithm name for Parameter
TempAns=zeros(28,3);
AverageCost=zeros(Average,3);
%% Loop
for i1=1:28
    for j1=1:Average
        it=0;
        MinTime=0;
        MinCost=inf;
        FailureTry=0;
        %% Data Defenition
        Model=Finalmodel(i1);
        T0=Parameter(AN4P,1);
        Alpha=Parameter(AN4P,2);
        MutationIndex=Parameter(AN4P,3);
        %% initialization
        costfunction=@(q)Cost(q,Model);
        %create an answer
        x.Position=RandomSolution(Model);
        x.Cost=costfunction(x.Position);
        BestSol=x;
        T=T0;
        %% SA loop
        while(FailureTry<50)
            tic
            xnew.Position=Mutation(MutationIndex,x.Position,Model);
            xnew.Cost=costfunction(xnew.Position);
            if (xnew.Cost<=x.Cost)
                x=xnew;
            else
                delta=xnew.Cost-x.Cost;
                p=exp(-delta/T);
                h=rand();
                if(p>=h)
                    x=xnew;
                end
            end
            if(x.Cost <=BestSol.Cost)
                BestSol=x;
            end
            
            tempTime=toc;
            if(x.Cost<MinCost )
                MinTime=MinTime+tempTime;
                FailureTry=0;
                MinCost=x.Cost;
                it=it+1;
            else
                FailureTry=FailureTry+1;
            end
            MinTime
            T=Alpha*T;
        end
        clc
        AverageCost(j1,1)=MinCost;
        AverageCost(j1,2)=MinTime;
        AverageCost(j1,3)=it;
        disp(j1);
    end
    
    TempAns(i1,1)=mean(AverageCost(:,1),1);
    TempAns(i1,2)=mean(AverageCost(:,2),1);
    TempAns(i1,3)=mean(AverageCost(:,3),1);
    disp([num2str(i1) 'from' '28']);
end
% %% Create Ans
% Ans=zeros(7,1);
% for i=1:7
%     N=(i-1)*4+1;
%     Ans(i,1)=mean(TempAns(N:N+3));
% end
%% Save
Ans=TempAns;
clearvars -except Ans
save('./Data/SA.mat');