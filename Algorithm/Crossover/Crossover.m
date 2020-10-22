function [Ans1 Ans2]=Crossover(Index,p,model)

if(Index==1)
    [Ans1 Ans2]=Crossover_OnePoint(p,model);
elseif (Index==2)
    [Ans1 Ans2]=Crossover_TwoPoint(p,model);
elseif (Index==3)
    [Ans1 Ans2]=Crossover_Uniform(p,model);
end
end

