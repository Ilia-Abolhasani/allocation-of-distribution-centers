function q=Mutation_Swap(q,model)
n=model.n;
Point=randsample(1:n-1,1);
q([Point,Point+1])=q([Point+1,Point]);
end