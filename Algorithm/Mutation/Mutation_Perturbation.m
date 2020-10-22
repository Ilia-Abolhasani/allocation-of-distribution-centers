function q=Mutation_Perturbation(q,model)
n=model.n;
Point=randsample(1:n,1);
q(Point)=q(Point)+(1/model.m);
if (q(Point)>=1)
   q(Point)=q(Point)-1; 
end
end