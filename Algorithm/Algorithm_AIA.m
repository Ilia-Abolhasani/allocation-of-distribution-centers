function Ans=Algorithm_AIA(Model,MaxIteration,Npop,PNc,MutationIndex)
%% Algorithm Identity :
% Artificial immune system algorithm
% Based on population
% Single objective , 1986

%% Problem definition
costfunction=@(q)Cost(q,Model);
Nc=floor(PNc*Npop);

%% initialization
Immune.Position=[];
Immune.Cost=[];
pop=repmat(Immune,Npop,1);
for i=1:Npop
    % intialize position
    pop(i).Position=RandomSolution(Model) ;
    % Evaluation
    pop(i).Cost=costfunction(pop(i).Position);
end
costs=[pop.Cost];
[costs locateofsortedcost]=sort(costs);
pop=pop(locateofsortedcost);
% Matrix to Hold Best Cost Values
BestCost=zeros(MaxIteration,1);
%% Main Loop of AIA
for it=1:MaxIteration
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
    BestCost(it)=pop(1).Cost;
end
Ans=BestCost(it);
% plot(BestCost);
end
