function [Ans1 Ans2]=Crossover_TwoPoint(p,model)
n=model.n;
Point=sort(randsample(1:n-1,2));
q1=p(1).Position;
q2=p(2).Position;
Ans1=[q2(1:Point(1)) q1(Point(1)+1:Point(2)) q2(Point(2)+1:n)];
Ans2=[q1(1:Point(1)) q2(Point(1)+1:Point(2)) q1(Point(2)+1:n)]; 
end