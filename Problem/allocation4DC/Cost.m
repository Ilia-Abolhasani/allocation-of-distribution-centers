function Ans=Cost(q, model)
%% Initialization
%Get model data
m=model.m;
n=model.n;
f=model.f;
b=model.b;
c=model.c;
%Cost = shipmentCost + openingCost
OpeningCost=0;
shipmentCost=0;

%% Coromosome Fixer
Min=min(q);
Max=max(q);
if(Min<=0 || Max>=1)
    Max=max(Max,1);
    Min=min(Min,0);
    Delta=Max-Min;
    q=abs((q/Delta)-eps);
end
%% Conver Continuous Choromosome to Discrete
Interval=1/model.m;
for i=1:model.n
    q(1,i)=floor(q(1,i)/Interval)+1;
end

%% Create Mask
Mask=zeros(m,n);
for i=1:n
    Mask(q(i),i)=1;
end

%% Establish cost
for i=1:m
    if (sum(Mask(i,:))~=0)
        OpeningCost=OpeningCost+f(i);
    end
end

%% shipment cost
temp=Mask.*c;
shipmentCost=sum(temp);
shipmentCost=shipmentCost.*b;
shipmentCost=sum(shipmentCost);

%% Ans return
Ans=shipmentCost+OpeningCost;

end

