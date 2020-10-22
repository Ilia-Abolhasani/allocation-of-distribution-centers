function Ans=Algorithm_FA(Model,MaxIteration,)
%% Algorithm Identity :
% 
% Based on population
% Single objective , 

%% initialization
costfunction=@(q)Cost(q,Model);

nvar=2*model.NMjadid ;              
 
%% Firefly Algorithm Parameters 
 
maxgen=400 ;                         
nfirefly=10 ;   
                     
gama=1 ;
m=2 ; 
beta0=1 ;
alpha=0.3 ;
 
delta=0.1*(model.xmax-model.xmin) ;              
delta2=0.1*(model.ymax-model.ymin) ;        
     
%% Initialization
 
 firefly.position=[] ;
firefly.cost=[] ;
 
pop=repmat(firefly,nfirefly,1) ; 
 
Bestsol.cost=inf ; 
 
for i=1:nfirefly
    pop(i).position=RandomSolution(model) ; 
    pop(i).cost=costfunction(pop(i).position) ;
       
   if pop(i).cost<=Bestsol.cost
            Bestsol=pop(i) ; 
   end
end
 
% matrix to hold best cost
Bestcost=zeros(maxgen,1) ; 
 
%% FA main loop 

for gen=1:maxgen
    
    newpop=pop ;    
    for i=1:nfirefly
       for j=1:nfirefly
            if pop(j).cost<=pop(i).cost
   beta=beta0*exp((-gama*norm(pop(j).position-newpop(i).position))^m) ;

               u=1:2:nvar ;
               r=2:2:nvar ;
               newpop(i).position(u)=pop(i).position(u)+beta*(pop(j).position(u)-...
      pop(i).position(u))+alpha*unifrnd(-delta,delta,1,nvar/2);
                newpop(i).position(r)=pop(i).position(r)+beta*(pop(j).position(r)-...
      pop(i).position(r))+alpha*unifrnd(-delta2,delta2,1,nvar/2);
               newpop(i).position(u)=max(newpop(i).position(u),model.xmin) ;
               newpop(i).position(u)=min(newpop(i).position(u),model.xmax) ;
               newpop(i).position(r)=max(newpop(i).position(r),model.ymin) ; 
               newpop(i).position(r)=min(newpop(i).position(r),model.ymax) ;
               
               newpop(i).cost=costfunction(newpop(i).position) ; 
               if newpop(i).cost<=Bestsol.cost
                   Bestsol=newpop(i) ; 
               end
           end
       end
    end
    
   pop=[pop
        newpop] ; 
   % sort population
   [s,sortorder]=sort([pop.cost]) ; 
   pop=pop(sortorder) ;
   
   pop=pop(1:nfirefly) ; 
   
   % store best cost ever iteration
   Bestcost(gen)=Bestsol.cost ; 
   
   % show informwtion in ever iteration
disp(['Generation (' num2str(gen) ') , Best Cost is : ' num2str(Bestcost(gen)) ]) ;
   
   %alpha=endalpha+((alpha-endalpha)*exp(-it)) ;
end
 
%% Result 
 
plot(Bestcost) ;
title('Best Cost of Each Generation') ;
xlabel('Number of Generation') ;
ylabel('cost') ;

end

