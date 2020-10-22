function Ans=Algorithm_ACO(Model,MaxIteration,)
%% Algorithm Identity :
% Ant Colony Optimization
% Based on population
% Single objective , 

%% initialization
costfunction=@(q)Cost(q,Model);
nvar=model.ncity ;
 
%% ACO Parameters
 
maxgen=150 ;    
 
Nant=50 ;      
 
Q=1 ;
tav0=1 ;          
alpha=1 ;
beta=1 ; 
ro=0.05 ;      % tabkhir rate
 
%% initialization
 
eta=1./model.d ;                 % makos distance
 
tav=tav0*ones(nvar,nvar) ;       % pheromone matrix
 
Bestcost=zeros(maxgen,1) ;
 
ant.q = [] ; 
ant.cost = [] ;
 
ant=repmat(ant,Nant,1) ;   % initial colony of ant
% Bestant
Bestant.cost=inf ;
 
%% ACO main loop
 
for gen=1:maxgen
    
   for k=1:Nant
       ant(k).q=randi([1,nvar]) ;
       for l=2:nvar
           i=ant(k).q(end) ;
           P=tav(i,:).^alpha.*eta(i,:).^beta ;
           P(ant(k).q)=0 ;      % jelogiri az entekhab shar gozarande shode
           P=P/sum(P);
           
           j=RouletteWheelSelection(P) ;    % entekhab shahr badi
           
           ant(k).q=[ant(k).q j] ;  % ezahge kardan shahre jadid b masir ant
       end

       ant(k).cost=Costfunction(ant(k).q) ;
       if ant(k).cost<Bestant.cost
           Bestant=ant(k) ;
       end
   end
   
   % Update pheromone
   for k=1:Nant
        
       q=ant(k).q ;
       q=[q q(1)] ;    %#ok
       for l=1:nvar
           i=q(l) ;
           j=q(l+1) ;
           tav(i,j)=tav(i,j)+Q/ant(k).cost ;
          
       end
        
   end
   
   % tabkhir e pheromone
   tav=(1-ro)*tav ;
   
   % store Bestcost
   Bestcost(gen)=Bestant.cost ;
   
   % show information
   disp(['Generation (' num2str(gen) ') , Bestcost is : ' num2str(Bestcost(gen))]) ; 
  if toc()>25 
 disp(['The Time Is :(' num2str(toc()) ' , Then The Algorithm Is Stopped' ]);
      break ;
  end
end
 
disp(['Best Path is :  [ ' num2str(Bestant.q) ' ] '])
 
%% Result
plot(Bestcost) ;
title('Best Cost of Each Generation') ;
xlabel('Number Of Genaretion') ;
ylabel('Cost')

end

