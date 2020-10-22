function Ans=Algorithm_TS(Model,MaxIteration,)
%% Algorithm Identity :
%
%
% Single objective ,

%% initialization
costfunction=@(q)Cost(q,Model);

nvar=model.I;
listofoperation =listofoperation(nvar);
Numberofoperation =numel(listofoperation) ;

%% Tabu Search parameters

maxgen=100 ;
Lengthoftabulist =round(0.3*Numberofoperation) ;
MinimumCost=0 ;

%% Initialazation stage

x.position=RandomSolution(model) ;

[x.cost x.sol]=costfunction(x.position)  ;

Bestsol=x ;

Bestcost=zeros(maxgen,1);

Tabucounter=zeros(Numberofoperation,1) ;

%% Tabu search Main Loop

for gen=1:maxgen
    
    for  i=1:Numberofoperation
        % Aspiration Criteria
        if Tabucounter(i)>0
            
            xnew.position=Dooperation(x.position,listofoperation {i});
            [xnew.cost xnew.sol]=costfunction(xnew.position) ;
            
            if xnew.cost <= (1-0.3)* x.cost
                
                xnew.operationindex=i ;
                x=xnew;
            end
        elseif Tabucounter (i)==0
            
            xnew.position=Dooperation(x.position,listofoperation {i});
            [xnew.cost xnew.sol]=costfunction(xnew.position) ;
            
            
            if xnew.cost<=x.cost
                
                xnew.operationindex=i ;
                x=xnew;
            end
        end
    end
    
    
    for  i=1:Numberofoperation
        if i==x.operationindex
            Tabucounter(i)=Lengthoftabulist ;
        else
            Tabucounter(i)=max(Tabucounter(i)-1,0) ;
        end
    end
    
    if x.cost<=Bestsol.cost
        Bestsol=x;
    end
    
    Bestcost(gen)=Bestsol.cost ;
    
    disp(['Generation ' num2str(gen) ', Bestcost is : ' num2str(Bestcost(gen))]);
    
    
    if  Bestcost(gen)<=MinimumCost
        break;
    end
end
Bestcost=Bestcost(1:gen);
disp([' Bestsequence is : ' num2str(Bestsol.position)]);

%% Results
plot(Bestcost) ;
title('Best Cost of Each Generation') ;
xlabel('Number Generation') ;
ylabel('Cost') ;
end

