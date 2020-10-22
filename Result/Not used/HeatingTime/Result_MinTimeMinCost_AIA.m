clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
AN4P='AIA';% Algorithm name for Parameter
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
        Npop=Parameter(AN4P,1);
        PNc=Parameter(AN4P,2);
        MutationIndex=Parameter(AN4P,3);
        
        %% Problem definition
        costfunction=@(q)Cost(q,Model);
        Nc=floor(PNc*Npop);
        
        %% initialization
        Immune.Position=[];
        Immune.Cost=[];
        pop=repmat(Immune,Npop,1);
        for i=1:Npop
            pop(i).Position=RandomSolution(Model) ;
            pop(i).Cost=costfunction(pop(i).Position);
        end
        costs=[pop.Cost];
        [costs locateofsortedcost]=sort(costs);
        pop=pop(locateofsortedcost);
        %% Main Loop of AIA
        while(FailureTry<20)
            tic
            % Select Nc of Best Immenue
            popab=pop(1:Nc);
            % Cloning
            Ncol=zeros(Nc,1);
            col=cell(Nc,1);
            for i=1:Nc
                Ncol(i)=(Nc-i+1);
                col{i}=repmat(popab(i),Ncol(i),1);
            end
            % Mutation
            newcol=cell(Nc,1);
            for i=1:Nc
                for j=1:Ncol(i)
                    for k=1:i
                        newcol{i}(j).Position=Mutation(MutationIndex,col{i}(j).Position ,Model);
                        newcol{i}(j).Cost=costfunction(newcol{i}(j).Position);
                    end
                end
                newcol{i}=newcol{i}';
            end
            % sort mutation population
            betweenpop=cell2mat(newcol);
            costs=[betweenpop.Cost];
            [costs locateofsortedcost]=sort(costs);
            betweenpop=betweenpop(locateofsortedcost);
            % update intial population
            pop((Npop-Nc+1):end)=betweenpop(1:Nc);
            % sort initial population
            costs=[pop.Cost];
            [costs locateofsortedcost]=sort(costs);
            pop=pop(locateofsortedcost);
            % sort best cost
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
% Ans=zeros(7,2);
% for i=1:7
%     N=(i-1)*4+1;
%     Ans(i,1)=mean(TempAns(N:N+3));
% end
%% Save
Ans=TempAns;
clearvars -except Ans
save('./Data/AIA.mat');