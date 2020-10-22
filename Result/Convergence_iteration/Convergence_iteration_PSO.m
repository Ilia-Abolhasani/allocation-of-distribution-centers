function Convergence_iteration_PSO(Index)
%% Add path & Address manage
addpath('../../../.');
AddPaths('../../.././','allocation4DC');
%% Data definition 
Model=Finalmodel(28);
MaxIteration=400;
Nparticle=Parameter('PSO',1);
d=Parameter('PSO',2);
c0=Parameter('PSO',3);
c1=Parameter('PSO',4);
c2=Parameter('PSO',5);
%% problem definition
costfunction=@(q)Cost(q,Model);

%% Initialization
Particle.Position=[];
Particle.Cost=[];
Particle.Velocity=[];
Particle.Pbest.Position=[];
Particle.Pbest.Cost=[];
Particles=repmat(Particle,Nparticle,1);
% Initialization Population
for i=1:Nparticle
    Particles(i).Position=RandomSolution(Model);
    Particles(i).Cost=costfunction(Particles(i).Position);
    Particles(i).Velocity=0;
    Particles(i).Pbest.Position=Particles(i).Position;
    Particles(i).Pbest.Cost=Particles(i).Cost;
end
ParticleCost=[Particles.Cost];
[MinParticleCost MinParticleLocation]=min(ParticleCost);
gBest=Particles(MinParticleLocation).Pbest;
BestCost=zeros(MaxIteration,1);
%% Main loop of PSO algorithm
for gen=1:MaxIteration
    for i=1:Nparticle
        % Calculation new Velocity
        Particles(i).Velocity=c0*Particles(i).Velocity...
            +c1*rand()*(Particles(i).Pbest.Position-...
            Particles(i).Position)+c2*rand()*...
            (gBest.Position-Particles(i).Position);
        % Calculation new Position
        Particles(i).Position=Particles(i).Position+Particles(i).Velocity;
        % calculate Cost
        Particles(i).Cost=costfunction(Particles(i).Position);
        % Comparison new Particles with gBest and Best answer
        if (Particles(i).Cost<Particles(i).Pbest.Cost)
            Particles(i).Pbest.Position=Particles(i).Position;
            Particles(i).Pbest.Cost=Particles(i).Cost;
            if (Particles(i).Pbest.Cost<gBest.Cost)
                gBest=Particles(i).Pbest;
            end
        end
    end
    c0=d*c0;
    BestCost(gen)=gBest.Cost;
end
Ans_PSO=BestCost;
%% Save
if(Index==1)
    clearvars -except Ans_PSO
    save('./Data/PSO01.mat');
elseif(Index==8)
    clearvars -except Ans_PSO
    save('./Data/PSO02.mat');
elseif(Index==15)
    clearvars -except Ans_PSO
    save('./Data/PSO03.mat');
elseif(Index==22)
    clearvars -except Ans_PSO
    save('./Data/PSO04.mat');
end
end