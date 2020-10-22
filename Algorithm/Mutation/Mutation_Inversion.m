function q=Mutation_Inversion(q,model)
n=model.n;
Point=sort(randsample(n,2));
q(Point(1):Point(2))= q(Point(2):-1:Point(1));
end