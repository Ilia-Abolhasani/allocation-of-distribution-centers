function Ans=Algorithm_PSO(Model,MaxIteration,Nparticle,d,c0,c1,c2)
%% Algorithm Identity :
% Particle swarm optimization algorithm
% Based on population
% Single objective , 1995

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
Ans=costfunction(gBest.Position);
%   plot(BestCost);
end