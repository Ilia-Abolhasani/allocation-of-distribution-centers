function Ans=Algorithm_KA(Model,MaxIteration,Nkeshtel,Smax,p1,p2)
%% Algorithm Identity :
% Keshtel algorithm
% Based on population
% Single objective , 2013

%% Problem Definition
costfunction=@(q)Cost(q,Model);

m1=round(p1*Nkeshtel);%Number of Best Answer population
m2=2*round((p2*Nkeshtel)/2);%Number of Middle Answer population
m3=Nkeshtel-(m1+m2);%Number of Worst Answer population

%% Intialization
individual.Position=[];
individual.Cost=[];
individual.NN=[];          %NearestNeighbor
Keshtel=repmat(individual,Nkeshtel,1);
% Intialize Population
for i=1:Nkeshtel
    %Intialize Position
    Keshtel(i).Position=RandomSolution(Model);
    %Evaluation
    Keshtel(i).Cost=costfunction(Keshtel(i).Position);
end
costs=[Keshtel.Cost];
[i,sortorder]=sort(costs);
Keshtel=Keshtel(sortorder);
BestCost=zeros(MaxIteration,1);
%% Keshtel Main Loop
for it=1:MaxIteration
    %Population for N1 Section
    LuckyKeshtel=Keshtel(1:m1);
    for k=1:m1
        pop=Keshtel(k+1:end);
        LuckyKeshtel(k).NN=Keshtel_NearestNeighbor(LuckyKeshtel(k).Position,pop);
        S=1;
        while S<=2*Smax-1
            y.Position=Keshtel_Swirl(LuckyKeshtel(k),LuckyKeshtel(k).NN,S,Smax);
            y.Cost=costfunction(y.Position);
            if y.Cost<LuckyKeshtel(k).Cost
                LuckyKeshtel(k).Position=y.Position;
                LuckyKeshtel(k).Cost=y.Cost;
                LuckyKeshtel(k).NN=Keshtel_NearestNeighbor(LuckyKeshtel(k).Position,Keshtel);
                S=1;
            else
                S=S+1;         
            end
        end
    end
    %Population for N2 Section
    popm2=repmat(individual,m2,1);
    for j=1:m2     
        Temp=j+m1;
        i=randsample([1:Temp-1 Temp+1:Nkeshtel],2);%Random selection two element from population
        p=[Keshtel(Temp).Position ; Keshtel(i(1)).Position ; Keshtel(i(2)).Position];
        popm2(j).Position=Crossover_MiddleAnswer(p,Model);
        popm2(j).Cost=costfunction(popm2(j).Position);
    end
    %Population for N3 Section
    popm3=repmat(individual,m3,1);
    for j=1:m3
        popm3(j).Position=RandomSolution(Model);
        popm3(j).Cost=costfunction(popm3(j).Position);
    end
    %% New Population
    Keshtel=[LuckyKeshtel
        popm2
        popm3];
    costs=[Keshtel.Cost];
    [costs locatsortcost]=sort(costs);
    Keshtel=Keshtel(locatsortcost);
    BestCost(it)=Keshtel(1).Cost;
end
Ans=BestCost(it);
%% Show Result
%plot(BestCost);
end

