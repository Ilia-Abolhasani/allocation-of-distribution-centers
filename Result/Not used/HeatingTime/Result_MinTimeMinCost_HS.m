clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
AN4P='HS';% Algorithm name for Parameter
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
        
        HMS=Parameter(AN4P,1);
        HMCR=Parameter(AN4P,2);
        PAR=Parameter(AN4P,3);
        X_MIN=Parameter(AN4P,4);
        X_MAX=Parameter(AN4P,5);
                
        %% Problem Definition
        costfunction=@(q)Cost(q,Model);
        
        nvar=Model.n;
        %% Intialization
        
        % Intialize Population
        Harmony.position=[];
        Harmony.cost=[];
        
        pop=repmat(Harmony,HMS,1);
        
        for i=1:HMS
            %Intialize Position
            pop(i).position=RandomSolution(Model);
            %Evaluation
            pop(i).cost=costfunction(pop(i).position);
        end
        
        %Sort Population
        costs=[pop.cost];
        [cost locateofsortedcost]=sort(costs);
        pop=pop(locateofsortedcost);
        
        %% harmony Search Main Loop
        while(FailureTry<50)
            tic        
        for j=1:nvar                
                %harmony memory
                r=rand();
                
                if r<HMCR
                    r1=randi(HMS,1,1);
                    newpop.position(j)=pop(r1).position(j);
                    
                    %pitch adjusting
                    r2=rand();
                    
                    if r2<PAR
                        newpop.position(j)=newpop.position(j)+rand()*X_MAX;
                    end
                    
                else
                    %random solution
                    newpop.position(j)=X_MIN+rand()*(X_MAX-X_MIN);
                end
            end
            %evaluation of new solution
            newpop.cost=costfunction(newpop.position);
            
            %compariong Xnew and worth harmony in harmony memory
            if newpop.cost<costs(end)
                pop=vertcat(pop(1:HMS-1,:),newpop);
            end
            %sort new population
            costs=[pop.cost];
            [cost locateofsortedcost]=sort(costs);
            pop=pop(locateofsortedcost);
             
            tempTime=toc;
            if(pop(1).cost<MinCost )
                MinTime=MinTime+tempTime;
                FailureTry=0;
                MinCost=pop(1).cost;
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
Ans=TempAns;
clearvars -except Ans
save('./Data/HS.mat');