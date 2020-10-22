clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
Iteration_SA=100;
AN4P='KaSa';% Algorithm name for Parameter
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
        Nkeshtel=Parameter(AN4P,1);
        p1=Parameter(AN4P,2);
        p2=Parameter(AN4P,3);
        MutationIndex=Parameter(AN4P,4);
        SA_MaxIteration=Iteration_SA;
        T0=Parameter(AN4P,5);
        Alpha=Parameter(AN4P,6);
        %% Problem Definition
        costfunction=@(q)Cost(q,Model);
        m1=round(p1*Nkeshtel);%Number of Best Answer population
        m2=2*round((p2*Nkeshtel)/2);%Number of Middle Answer population
        m3=Nkeshtel-(m1+m2);%Number of Worst Answer population
        
        %% Intialization
        individual.Position=[];
        individual.Cost=[];
        individual.NN=[];%NearestNeighbor
        Keshtel=repmat(individual,Nkeshtel,1);
        % Intialize Population
        for i=1:Nkeshtel
            %Intialize Position
            Keshtel(i).Position=RandomSolution(Model);
            %Evaluation
            Keshtel(i).Cost=costfunction(Keshtel(i).Position);
        end
        costs=[Keshtel.Cost];
        [i,sortorder]=sort(costs);
        Keshtel=Keshtel(sortorder);
        %% Keshtel Main Loop
        while(FailureTry<20)
            tic
            %Population for N1 Section
            popm1=Keshtel(1:m1);
            for k=1:m1
                %% SA
                x.Position=Keshtel(k).Position;
                x.Cost=Keshtel(k).Cost;
                BestSol=x;
                T=T0;
                % SA loop
                for gen=1:SA_MaxIteration
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
                    T=Alpha*T;
                end
                if(BestSol.Cost>Keshtel(k).Cost)
                    popm1(k)=BestSol;
                else
                    popm1(k)=Keshtel(k);
                end
            end
            %Population for N2 Section
            popm2=repmat(individual,m2,1);
            for j=1:m2
                Temp=j+m1;
                i=randsample([1:Temp-1 Temp+1:Nkeshtel],2);%Random selection two element from population
                p=[Keshtel(Temp).Position ; Keshtel(i(1)).Position ; Keshtel(i(2)).Position];
                popm2(j).Position=Crossover_MiddleAnswer(p,Model);
                popm2(j).Cost=costfunction(popm2(j).Position);
            end
            %Population for N3 Section
            popm3=repmat(individual,m3,1);
            for j=1:m3
                popm3(j).Position=RandomSolution(Model);
                popm3(j).Cost=costfunction(popm3(j).Position);
            end
            %% New Population
            Keshtel=[popm1
                popm2
                popm3];
            costs=[Keshtel.Cost];
            [costs locatsortcost]=sort(costs);
            Keshtel=Keshtel(locatsortcost);
            tempTime=toc;
            if(Keshtel(1).Cost<MinCost )
                MinTime=MinTime+tempTime;
                FailureTry=0;
                MinCost=Keshtel(1).Cost;
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
% %% Create Ans
% Ans=zeros(7,1);
% for i=1:7
%     N=(i-1)*4+1;
%     Ans(i,1)=mean(TempAns(N:N+3));
% end
%% Save
Ans=TempAns;
clearvars -except Ans
save('./Data/KaSa.mat');