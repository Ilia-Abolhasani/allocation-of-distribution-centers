function Convergence_iteration_SA(Index)
%% Add path & Address manage
addpath('../../../.');
AddPaths('../../.././','allocation4DC');
%% Data definition
Model=Finalmodel(Index);
MaxIteration=400;
T0=Parameter('SA',1);
Alpha=Parameter('SA',2);
MutationIndex=Parameter('SA',3);

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
Ans_SA=BestCost;
%% Save
if(Index==1)
    clearvars -except Ans_SA
    save('./Data/SA01.mat');
elseif(Index==8)
    clearvars -except Ans_SA
    save('./Data/SA02.mat');
elseif(Index==15)
    clearvars -except Ans_SA
    save('./Data/SA03.mat');
elseif(Index==22)
    clearvars -except Ans_SA
    save('./Data/SA04.mat');
end
end