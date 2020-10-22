function [Ans1 Ans2]=Crossover_OnePoint(p,model)
n=model.n;
Point=randsample(1:n-1,1);
q1=p(1).Position;
q2=p(2).Position;
Ans1=[q1(1:Point) q2(Point+1:n)];
Ans2=[q2(1:Point) q1(Point+1:n)]; 
end