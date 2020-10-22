function Ans=Algorithm_GA(Model,MaxIteration,Npop,PCrossover,PMutation,MutationIndex,CrossoverIndex)
%% Algorithm Identity :
% Genetic algorithm
% Based on population
% Single objective , 1975

%% initialization
costfunction=@(q)Cost(q,Model);

NMutation=floor((PMutation*Npop));

NCrossover=2*round((PCrossover*Npop)/2);

individual.Position=[];
individual.Cost=[];

BestCost=zeros(MaxIteration,1);
%% Initial population
pop=repmat(individual,Npop,1);
for i=1:Npop
    pop(i).Position=RandomSolution(Model);
    pop(i).Cost=costfunction(pop(i).Position);
end
%% GA Main loop
for gen=1:MaxIteration
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
    BestCost(gen)=pop(1).Cost;
end
Ans=BestCost(gen);
%% Show Result
% plot(BestCost);
end

