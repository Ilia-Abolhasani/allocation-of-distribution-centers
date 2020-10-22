function Ans=Algorithm_SA(Model,MaxIteration,T0,Alpha,MutationIndex)
%% Algorithm Identity :
% Simulated annealing algorithm
% Single point
% Single objective , 1983

%% initialization
costfunction=@(q)Cost(q,Model);
%create an answer
x.Position=RandomSolution(Model);
x.Cost=costfunction(x.Position);
BestSol=x;
BestCost=zeros(MaxIteration,1);
T=T0;
%% SA loop
for gen=1:MaxIteration
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
    BestCost(gen)=BestSol.Cost;
    T=Alpha*T;
end
Ans=costfunction(BestSol.Position);
%% Result
%figure
%plot(BestCost);
% BestSol.Position
end
