function Ans=Algorithm_HS(Model,MaxIteration,HMS,HMCR,PAR,X_MIN,X_MAX)
%% Algorithm Identity :
% Harmony search algorithm
% Based on population
% Single objective , 2001

%% Problem Definition
costfunction=@(q)Cost(q,Model);

nvar=Model.n;
%% Intialization

% Intialize Population
Harmony.position=[];
Harmony.cost=[];

pop=repmat(Harmony,HMS,1);

for i=1:HMS
    %Intialize Position
    pop(i).position=RandomSolution(Model);
    %Evaluation
    pop(i).cost=costfunction(pop(i).position);
end

%Sort Population
costs=[pop.cost];
[cost locateofsortedcost]=sort(costs);
pop=pop(locateofsortedcost);

%Hold Best Cost Value
Bestcost=zeros(MaxIteration,1);
%% harmony Search Main Loop
for it=1:MaxIteration
    for j=1:nvar
        
        %harmony memory
        r=rand();
        
        if r<HMCR
            r1=randi(HMS,1,1);
            newpop.position(j)=pop(r1).position(j);
            
            %pitch adjusting
            r2=rand();
            
            if r2<PAR
                newpop.position(j)=newpop.position(j)+rand()*X_MAX;
            end
            
        else
            %random solution
            newpop.position(j)=X_MIN+rand()*(X_MAX-X_MIN);
        end
    end
    %evaluation of new solution
    newpop.cost=costfunction(newpop.position);
    
    %compariong Xnew and worth harmony in harmony memory
    if newpop.cost<costs(end)
        pop=vertcat(pop(1:HMS-1,:),newpop);
    end
    %sort new population
    costs=[pop.cost];
    [cost locateofsortedcost]=sort(costs);
    pop=pop(locateofsortedcost);
    %sort best cost
    Bestcost(it)=pop(1).cost;
end
Ans=Bestcost(it);
%% Show Result
%    plot(Bestcost);
end