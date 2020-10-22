function Ans=Convert28to7(input)
Ans01=zeros(28,1);
for i=1:28
    Ans01(i)=mean(RPD(input(i,:),2));
end
Ans=zeros(7,1);
for i=0:6
    Ans(i+1)=mean([Ans01((i*4)+1),Ans01((i*4)+2),Ans01((i*4)+3),Ans01((i*4)+4)]);
end
end