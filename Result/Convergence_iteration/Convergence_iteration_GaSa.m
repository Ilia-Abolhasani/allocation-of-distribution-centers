function Convergence_iteration_GaSa(Index)
%% Add path & Address manage
addpath('../../../.');
AddPaths('../../.././','allocation4DC');
%% Data definition 
Model=Finalmodel(28);
MaxIteration=400;
Npop=Parameter('GaSa',1);
PCrossover=Parameter('GaSa',2);
PSa=Parameter('GaSa',3);
MutationIndex=Parameter('GaSa',4);
CrossoverIndex=Parameter('GaSa',5);
SA_MaxIteration=25;
T0=Parameter('GaSa',6);
Alpha=Parameter('GaSa',7);
%% initialization
costfunction=@(q)Cost(q,Model);

NSa=floor((PSa*Npop));

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
    %% population SA
    popSA=repmat(individual,NSa,1);
    i=randsample(1:Npop,NSa);
    for k=1:NSa
        %% set parameter
        x.Position=pop(i(k)).Position;
        x.Cost=pop(i(k)).Cost;
        BestSol=x;
        T=T0;
        %% SA loop
        for SA_gen=1:SA_MaxIteration
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
        popSA(k).Position=BestSol.Position;
        popSA(k).Cost=costfunction(BestSol.Position);
    end
    %% Pool fusion & Selection Best Chromosome
    pop=[pop
        popC
        popSA];
    costs=[pop.Cost];
    [costs locatsortedcost]=sort(costs);
    pop=pop(locatsortedcost);
    pop=pop(1:Npop);
    BestCost(gen)=pop(1).Cost;
end
Ans_GaSa=BestCost;
%% Save
if(Index==1)
    clearvars -except Ans_GaSa
    save('./Data/GaSa01.mat');
elseif(Index==8)
    clearvars -except Ans_GaSa
    save('./Data/GaSa02.mat');
elseif(Index==15)
    clearvars -except Ans_GaSa
    save('./Data/GaSa03.mat');
elseif(Index==22)
    clearvars -except Ans_GaSa
    save('./Data/GaSa04.mat');
end
end