function q=Crossover_MiddleAnswer(p,model)

Landa=rand();

p(2,:)=p(2,:)*Landa;
p(3,:)=p(3,:)*(1-Landa);

q=p(1,:)+(rand()*(p(2,:)+p(3,:)));

end