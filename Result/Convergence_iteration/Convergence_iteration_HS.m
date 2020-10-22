function Convergence_iteration_HS(Index)
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition 
Model=Finalmodel(28);
MaxIteration=400;
HMS=Parameter('HS',1);
HMCR=Parameter('HS',2);
PAR=Parameter('HS',3);
X_MIN=Parameter('HS',4);
X_MAX=Parameter('HS',5);

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
Ans_HS=Bestcost;
%% Save
if(Index==1)
    clearvars -except Ans_HS
    save('./Data/HS01.mat');
elseif(Index==8)
    clearvars -except Ans_HS
    save('./Data/HS02.mat');
elseif(Index==15)
    clearvars -except Ans_HS
    save('./Data/HS03.mat');
elseif(Index==22)
    clearvars -except Ans_HS
    save('./Data/HS04.mat');
end
end