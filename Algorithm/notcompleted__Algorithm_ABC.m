function Ans=Algorithm_ABC(Model,MaxIteration,)
%% Algorithm Identity :
% 
% Based on population
% Single objective , 

%% initialization
costfunction=@(q)Cost(q,Model); 
 
nvar=2*model.NMjadid ; 
 
%% ABC Parameters 
 
maxgen=500 ;            
 
Nbee=30 ;         
 
NFood=Nbee/2 ;           
 
limit=100 ;              
 
%% Initialization

Food.position=[] ; 
Food.cost=[] ;
 
Foods=repmat(Food,NFood,1) ; 

for  i=1:NFood 
   Foods(i).position=RandomSolution(model) ; 
   Foods(i).cost=costfunction(Foods(i).position) ;
end
 
trial=zeros(1,NFood); 

[minfoodcost minfoodcostlocate]=min([Foods.cost]) ;
 
Bestfood=Foods(minfoodcostlocate) ; 
BestFood=zeros(1,maxgen) ; 
 
%% ABC Main Loop 

for gen=1:maxgen
                        
% EMPLOYED BEE PHASE  
     for i=1:(NFood)

        neighbour=randsample(NFood,1) ; 
       
            while (neighbour==i)
                neighbour=randsample(NFood,1);
            end;
        
        Param2Change=randsample(nvar,1) ; 
        
       sol.position=Foods(i).position ;

  sol.position(Param2Change)=Foods(i).position(Param2Change)+unifrnd(-1,1) *(Foods(i).position(Param2Change)-Foods(neighbour).position(Param2Change));
        
         
       u=1:2:nvar ;
       r=2:2:nvar ;
       sol.position(u)=max(sol.position(u),model.xmin) ;
       sol.position(u)=min(sol.position(u),model.xmax) ;
       sol.position(r)=max(sol.position(r),model.ymin) ;
       sol.position(r)=min(sol.position(r),model.ymax) ;
              
       
        sol.cost=costfunction(sol.position); 
        
        
       if (sol.cost<Foods(i).cost)          
            Foods(i)=sol ;                  
            trial(i)=0;
        else
            trial(i)=trial(i)+1;            
       end 
     end
    
                           
% ONLOOKER BEE PHASE  
costs=[Foods.cost];
prob=zeros(1,NFood) ;
for index=1:NFood
prob(index)=Foods(index).cost./sum(costs) ; 
end
 

i=1;
t=0;
while (t<NFood)
    if(rand<prob(i))
        t=t+1;

        neighbour=randsample(NFood,1);
       
            while(neighbour==i)
                neighbour=randsample(NFood,1) ;
            end;
        

        Param2Change=randsample(nvar,1) ;
        
        sol.position=Foods(i).position ;

sol.position(Param2Change)=Foods(i).position(Param2Change)+unifrnd(-1,1) *(Foods(i).position(Param2Change)-Foods(neighbour).position(Param2Change));
        
        
        u=1:2:nvar ;
        r=2:2:nvar ;
        sol.position(u)=max(sol.position(u),model.xmin) ;
        sol.position(u)=min(sol.position(u),model.xmax) ;
        sol.position(r)=max(sol.position(r),model.ymin) ;
        sol.position(r)=min(sol.position(r),model.ymax) ;
        
         sol.cost=costfunction(sol.position);
        
       
       if (sol.cost<Foods(i).cost)          
            Foods(i)=sol ;                  
            trial(i)=0;
        else
            trial(i)=trial(i)+1;           
       end 
    end
    
    i=i+1;
    if (i==(NFood)+1) 
        i=1;
    end  
end
 

         [minfoodcost minfoodcostlocate]=min([Foods.cost]) ; 
         if (Foods(minfoodcostlocate).cost<Bestfood.cost)
            Bestfood=Foods(minfoodcostlocate) ; 
         end

                         
 % SCOUT BEE PHASE  
        ind=find(trial==max(trial)); 

        if  (trial(ind)>limit)
            trial(ind)=0;
            sol.position=RandomSolution(model) ;
            sol.cost=costfunction(sol.position) ;
            Foods(ind)=sol;
        end;

    BestFood(gen)=Bestfood.cost ;

disp(['Generation (' num2str(gen) ') , Bestcost is : ' num2str(BestFood(gen))]);

end
 
%% Result
 
plot(BestFood) ; 
title('Best Cost of Each Generation') ;
xlabel('Number of Generation') ;
ylabel('cost') ;

end

