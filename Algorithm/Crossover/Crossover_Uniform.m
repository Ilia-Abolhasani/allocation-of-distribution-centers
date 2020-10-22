function [Ans1 Ans2]=Crossover_Uniform(p,model)
n=model.n;
Mask=randsample(0:1,n,1);
Ans1=p(1).Position;
Ans2=p(2).Position;
for i=1:n
    if(Mask(i)==0)
        temp=Ans1(i);
        Ans1(i)=Ans2(i);
        Ans2(i)=temp;
    end
end 
end