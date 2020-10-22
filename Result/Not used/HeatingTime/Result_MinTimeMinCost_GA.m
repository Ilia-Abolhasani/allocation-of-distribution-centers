clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
AN4P='GA';% Algorithm name for Parameter
TempAns=zeros(28,3);
AverageCost=zeros(Average,3);
%% Loop
for i1=1:28
    for j1=1:Average        
        it=0;
        MinTime=0;
        MinCost=inf;
        FailureTry=0;
        %%Data Defenition
        Model=Finalmodel(i1);
        
        Npop=Parameter(AN4P,1)
        PCrossover=Parameter(AN4P,2)
        PMutation=Parameter(AN4P,3)
        MutationIndex=Parameter(AN4P,4),
        CrossoverIndex=Parameter(AN4P,5);
        
        %% initialization
        costfunction=@(q)Cost(q,Model);        
        NMutation=floor((PMutation*Npop));        
        NCrossover=2*round((PCrossover*Npop)/2);        
        individual.Position=[];
        individual.Cost=[];                
        %% Initial population
        pop=repmat(individual,Npop,1);
        for i=1:Npop
            pop(i).Position=RandomSolution(Model);
            pop(i).Cost=costfunction(pop(i).Position);
        end
        %% GA Main loop
         while(FailureTry<20)
            tic
            %% population Crossover
            popC=repmat(individual,NCrossover,1);
            for k=1:2:NCrossover
                i=randsample(1:Npop,2);
                p=pop(i);
                [Ans1 Ans2]=Crossover(CrossoverIndex,p,Model);
                popC(k).Position=Ans1;
                popC(k+1).Position=Ans2;
                popC(k).Cost=costfunction(popC(k).Position);
                popC(k+1).Cost=costfunction(popC(k+1).Position);
            end
            %% population Mutation
            popM=repmat(individual,NMutation,1);
            for k=1:NMutation
                i=randsample(1:Npop,1);
                Answer=Mutation(MutationIndex,pop(i).Position ,Model);
                popM(k).Position=Answer;
                popM(k).Cost=costfunction(popM(k).Position);
            end
            %% Pool fusion & Selection Best Chromosome
            pop=[pop
                popC
                popM];
            costs=[pop.Cost];
            [costs locatsortedcost]=sort(costs);
            pop=pop(locatsortedcost);
            pop=pop(1:Npop);
             tempTime=toc;
            if(pop(1).Cost<MinCost )
                MinTime=MinTime+tempTime;
                FailureTry=0;
                MinCost=pop(1).Cost;
                it=it+1;
            else
                FailureTry=FailureTry+1;
            end
            MinTime
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
%% Create Ans
% Ans=zeros(7,1);
% for i=1:7
%     N=(i-1)*4+1;
%     Ans(i,1)=mean(TempAns(N:N+3));
% end
%% Save
clearvars -except Ans
save('./Data/GA.mat');