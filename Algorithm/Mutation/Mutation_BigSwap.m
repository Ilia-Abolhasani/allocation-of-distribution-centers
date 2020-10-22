function q=Mutation_BigSwap(q,model)
n=model.n;
Point=randsample(1:n,2);
q([Point(1),Point(2)])=q([Point(2),Point(1)]);
end