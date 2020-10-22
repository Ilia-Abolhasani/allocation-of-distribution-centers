clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%% Data definition
Average=5;
AN4P='PSO';% Algorithm name for Parameter
TempAns=zeros(28,3);
AverageCost=zeros(Average,3);
%% Loop
for i1=1:28
    for j1=1:Average
        
        it=0;
        MinTime=0;
        MinCost=inf;
        FailureTry=0;
        %%Data Defenition
        Model=Finalmodel(i1);
        Nparticle=Parameter(AN4P,1);
        d=Parameter(AN4P,2);
        c0=Parameter(AN4P,3);
        c1=Parameter(AN4P,4);
        c2=Parameter(AN4P,5);
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
        
        %% Main loop of PSO algorithm
        while(FailureTry<20)
            tic
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
            tempTime=toc;
            if(gBest.Cost<MinCost )
                MinTime=MinTime+tempTime;
                FailureTry=0;
                MinCost=gBest.Cost;
                it=it+1;
            else
                FailureTry=FailureTry+1;
            end
            MinTime
        end
        clc
        AverageCost(j1,1)=MinCost;
        AverageCost(j1,2)=MinTime;
        AverageCost(j1,3)=it;
        disp(j1);
    end
    TempAns(i1,1)=mean(AverageCost(:,1),1);
    TempAns(i1,2)=mean(AverageCost(:,2),1);
    TempAns(i1,3)=mean(AverageCost(:,3),1);
    disp([num2str(i1) 'from' '28']);
end
%% Create Ans
% Ans=zeros(7,1);
% for i=1:7
%     N=(i-1)*4+1;
%     Ans(i,1)=mean(TempAns(N:N+3));
% end
%% Save
Ans=TempAns;
clearvars -except Ans
save('./Data/PSO.mat');