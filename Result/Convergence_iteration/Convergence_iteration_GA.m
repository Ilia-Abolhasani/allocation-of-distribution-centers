function Convergence_iteration_GA(Index)
%% Add path & Address manage
addpath('../../../.');
AddPaths('../../.././','allocation4DC');
%% Data definition 
Model=Finalmodel(28);
MaxIteration=400;
Npop=Parameter('GA',1);
PCrossover=Parameter('GA',2);
PMutation=Parameter('GA',3);
MutationIndex=Parameter('GA',4);
CrossoverIndex=Parameter('GA',5);

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
Ans_GA=BestCost;


%% Save
if(Index==1)
    clearvars -except Ans_GA
    save('./Data/GA01.mat');
elseif(Index==8)
    clearvars -except Ans_GA
    save('./Data/GA02.mat');
elseif(Index==15)
    clearvars -except Ans_GA
    save('./Data/GA03.mat');
elseif(Index==22)
    clearvars -except Ans_GA
    save('./Data/GA04.mat');
end
end