function Ans = Parameter(Algorithm_Name,Parameter_index )
%Data calculate by tuning M file
%   Enter algorithm index in first input
%   Enter Parameter index in secound input
if(strcmp(Algorithm_Name,'SA'))% Not Completed ,Warning!!!!!!!!!!!!!!!!!!!!!!!!
    %% SA
    %T0 , Alpha , MutationIndex
    SA_Parameter=[1200,0.99,2];
    Ans=SA_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'GA'))% Completed
    %% GA
    %Npop , PCrossover , PMutation , MutationIndex , CrossoverIndex
    GA_Parameter=[100,0.945,0.08,2,3];
    Ans=GA_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'KA')) % Completed
    %% KA
    %Nkeshtel , Smax , p1 , p2
    KA_Parameter=[350,25,0.2,0.3];
    Ans=KA_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'AIA'))% Not Completed ,Warning!!!!!!!!!!!!!!!!!!!!!!!!
    %% AIA
    %Npop , PNc , MutationIndex
    AIA_Parameter=[30,0.5,2];
    Ans=AIA_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'PSO'))% Completed
    %% PSO
    %Nparticle , d , c0 , c1 , c2
    PSO_Parameter=[30,0.99,0.9,1.6,2];
    Ans=PSO_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'HS'))% Not Completed ,Warning!!!!!!!!!!!!!!!!!!!!!!!!
    %% HS
    % HMS , HMCR , PAR , X_MIN , X_MAX 
    HS_Parameter=[10,0.99,0.01,0,1];
    Ans=HS_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'GaSa'))% Not Completed ,Warning!!!!!!!!!!!!!!!!!!!!!!!!
    %% GaSa
    %Npop , PCrossover , PSa , MutationIndex , CrossoverIndex , T0 , Alpha
    GaSa_Parameter=[100,0.945,0.1,2,3,1200,0.99];
    Ans=GaSa_Parameter(Parameter_index);
    return
elseif(strcmp(Algorithm_Name,'KaSa'))% Not Completed ,Warning!!!!!!!!!!!!!!!!!!!!!!!!
    %% KaSa
    %Nkeshtel,p1,p2,MutationIndex,T0,Alpha)
    KaSa_Parameter=[350,0.2,0.3,2,1200,0.99];    
    Ans=KaSa_Parameter(Parameter_index);
    return
else
    disp('error in Parameter m file');
end
end

