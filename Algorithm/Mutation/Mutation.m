function q=Mutation(Index,q,model)
switch(Index)
    case 1
    q=Mutation_Swap(q,model);
    case 2
    q=Mutation_BigSwap(q,model);
    case 3
    q=Mutation_Inversion(q,model);
    case 4
    q=Mutation_Displacement(q,model);
    case 5
    q=Mutation_Perturbation(q,model);           
end
end
