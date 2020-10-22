function Ans=Algorithm_ICA(Model,MaxIteration,NCountry,NImperial,Beta,Epselon,Gama,PRevolution,PDeflection)
%% Algorithm Identity :
% Imperialist competitive algorithm
% Based on population
% Single objective , 1975

%% initialization
costfunction=@(q)Cost(q,Model);

Ncol=NCountry-NImperial ;

%% Country struct
Country.position=[];
Country.cost=[];
%% Country population
popCountry=repmat(Country,NCountry,1);
%% Initial country population
for  i=1:NCountry
    popCountry(i).position=RandomSolution(Model) ;
    popCountry(i).cost=costfunction(popCountry(i).position) ;
end
%% sort Countrys
costs=[popCountry.cost] ;
[costs locatesortedcost]=sort(costs) ;
popCountry=popCountry(locatesortedcost) ;
%% imperial struct
Imperial.position=[] ;
Imperial.cost=[] ;
Imperial.totalcost=[] ;
Imperial.colonies=[] ;
Imperial.Ncol=[] ;
%% Imperial population
Imperial=repmat(Imperial,NImperial,1) ;
%% Initial Imperial population
for i=1:NImperial
    Imperial(i).position=popCountry(i).position ;
    Imperial(i).cost=popCountry(i).cost ;
end
% remove imperial from countrys population
popCountry=popCountry(NImperial+1:end) ;
%% Condition for find error
if  isempty(popCountry)
    disp('Error!');
    return;
end
%%
impcosts=[Imperial.cost];
Maximpcost=max(impcosts);
impfitness=1.2*Maximpcost-impcosts;
p=impfitness/sum(impfitness);
nc=round(p*Ncol);
sumnc=sum(nc);
if sumnc>Ncol
    i=1;
    while sumnc>Ncol
        nc(i)=max(nc(i)-1,0);
        i=i+1;
        if i>NImperial
            i=1;
        end
        sumnc=sum(nc);
    end
elseif sumnc<Ncol
    i=NImperial;
    while sumnc<Ncol
        nc(i)=nc(i)+1;
        i=i-1;
        if i<1
            i=NImperial;
        end
        sumnc=sum(nc);
    end
end
%%
popCountry=popCountry(randperm(Ncol));

for  i=1:NImperial
    Imperial(i).Ncol=nc(i);
    Imperial(i).colonies=popCountry(1:nc(i));
    popCountry=popCountry(nc(i)+1:end);
end

Bestsol=[] ;
Bestcost=zeros(MaxIteration,1) ;
Meancost=zeros(MaxIteration,1) ;

%% ICA Main Loop
for gen=1:MaxIteration
    
    %  assimilate colonies
    for i=1:NImperial
        for j=1:Imperial(i).Ncol
            Imperial(i).colonies(j).position =Imperial(i).colonies(j).position+Beta*rand...
                *(Imperial(i).position-Imperial(i).colonies(j).position) ;
            
            u=1:2:nvar ;
            r=2:2:nvar ;
            Imperial(i).colonies(j).position(u)=max(Imperial(i).colonies(j).position(u),Model.xmin) ;
            Imperial(i).colonies(j).position(u)=min(Imperial(i).colonies(j).position(u),Model.xmax) ;
            Imperial(i).colonies(j).position(r)=max(Imperial(i).colonies(j).position(r),Model.ymin) ;
            Imperial(i).colonies(j).position(r)=min(Imperial(i).colonies(j).position(r),Model.ymax) ;
            
            Imperial(i).colonies(j).cost=costfunction(Imperial(i).colonies(j).position) ;
        end
    end
    
    % Deflection colonies
    for a=1:NImperial
        for b=1:Imperial(a).Ncol
            if rand<PDeflection
                
                u=1:2:nvar ;
                r=2:2:nvar ;
                Imperial(a).colonies(b).position(u)=Imperial(a).colonies(b).position(u)...
                    +PDeflection*unifrnd(-delta,delta,1,nvar/2);
                Imperial(a).colonies(b).position(r)=Imperial(a).colonies(b).position(r)...
                    +PDeflection*unifrnd(-delta2,delta2,1,nvar/2);
                
                Imperial(a).colonies(b).position(u)=max(Imperial(a).colonies(b).position(u),Model.xmin) ;
                Imperial(a).colonies(b).position(u)=min(Imperial(a).colonies(b).position(u),Model.xmax) ;
                Imperial(a).colonies(b).position(r)=max(Imperial(a).colonies(b).position(r),Model.ymin) ;
                Imperial(a).colonies(b).position(r)=min(Imperial(a).colonies(b).position(r),Model.ymax) ;
                
                Imperial(a).colonies(b).cost=costfunction(Imperial(a).colonies(b).position) ;
            end
        end
    end
    
    % Revolution colonies
    for t=1:NImperial
        for y=1:Imperial(t).Ncol
            if rand<Revolutionrate
                m=randsample(nvar,1) ;
                k=randsample(nvar,m) ;
                u=1:2:nvar ;
                r=2:2:nvar ;
                for z=1:m
                    if intersect(k(z),u)>0
                        Imperial(t).colonies(y).position(k(z))=unifrnd(Model.xmin,Model.xmax) ;
                    elseif intersect(k(z),r)>0
                        Imperial(t).colonies(y).position(k(z))=unifrnd(Model.ymin,Model.ymax) ;
                    end
                end
                Imperial(t).colonies(y).cost=costfunction(Imperial(t).colonies(y).position) ;
            end
        end
    end
    
    %  Switch Imperialist and colonies if colonies had beter cost
    
    for q=1:NImperial
        colonycosts=[Imperial(q).colonies.cost] ;
        [Bestcolonycost Bestcolonylocate]=min(colonycosts) ;
        Bestcolony=Imperial(q).colonies(Bestcolonylocate) ;
        if Bestcolony.cost<Imperial(q).cost
            Imperial(q).colonies(Bestcolonylocate).position=Imperial(q).position ;
            Imperial(q).colonies(Bestcolonylocate).cost=Imperial(q).cost ;
            Imperial(q).position=Bestcolony.position ;
            Imperial(q).cost=Bestcolony.cost ;
        end
    end
    
    %  caculation total cost of imperialst
    
    for w=1:NImperial
        Imperial(w).totalcost=Imperial(w).cost+Epselon*mean([Imperial(w).colonies.cost]) ;
    end
    
    %%  Imperialist Competitive
    if NImperial<2
        break ;
    else
        imptotalcost=[Imperial.totalcost] ;
        [Maximpcost NofMaximpcost]=max(imptotalcost) ;
        
        [Maxcolcost NofMaxcolcost]=max([Imperial(NofMaximpcost).colonies.cost]) ;
        impvalue=Maximpcost-[Imperial.totalcost] ;
        p=impvalue/sum(impvalue);
        l=RouletteWheelSelection(p) ;
        Imperial(l).colonies=[Imperial(l).colonies
            Imperial(NofMaximpcost).colonies(NofMaxcolcost)] ;
        
        Imperial(l).Ncol=numel([Imperial(l).colonies]) ;
        
        Imperial(NofMaximpcost).colonies(NofMaxcolcost)= [] ;
        
        Imperial(NofMaximpcost).Ncol=numel([Imperial(NofMaximpcost).colonies]) ;
        if  Imperial(NofMaximpcost).Ncol==0
            % weakest imp. will collapse
            L=RouletteWheelSelection(p) ;
            newcolony.position=Imperial(NofMaximpcost).position ;
            newcolony.cost=Imperial(NofMaximpcost).cost ;
            Imperial(L).colonies=[Imperial(L).colonies
                newcolony] ;
            Imperial(L).Ncol=numel([Imperial(L).colonies]) ;
            Imperial=Imperial([1:NofMaximpcost-1 NofMaximpcost+1:end]) ;
            NImperial=NImperial-1 ;
        end
    end
    
    %% final activity for show result
    [Bestimpcost Bestimpcostlocate]=min([Imperial.cost]) ;
    Bestimperial=Imperial(Bestimpcostlocate) ;
    Bestsol.position=Bestimperial.position ;
    Bestsol.cost=Bestimperial.cost ;
    Bestcost(gen)=Bestsol.cost ;
    
    disp(['Generation : (' num2str(gen) ') , Best cost is :' num2str(Bestcost(gen))]) ;
end

disp(['Best Solution is: ' num2str(Bestsol.position)]) ;

%% Show Result
plot(Bestcost) ;
title('Best Cost of Each Generation') ;
xlabel('Number of Generation') ;
ylabel('cost') ;

end

