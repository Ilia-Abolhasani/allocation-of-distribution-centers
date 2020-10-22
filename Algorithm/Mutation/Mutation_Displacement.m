function q=Mutation_Displacement(q,model)
n=model.n;
Point=sort(randsample(2:n,2));
temp=q(Point(1):Point(2));
q1=q(1:Point(1)-1);
q2=[];
if(Point(2)~=n)
    q2=q(Point(2)+1:end);
end
q=[temp q1 q2];
end