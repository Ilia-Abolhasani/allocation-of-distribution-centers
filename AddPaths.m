function AddPaths(Str,ProblemName)
%% Algorithm directory
addpath([Str , 'Algorithm']);
addpath([Str , 'Algorithm/Crossover']);
addpath([Str , 'Algorithm/Keshtel_function']);
addpath([Str , 'Algorithm/Mutation']);

%% Tuning directory
addpath([Str , 'Tuning']);

%% Statistic directory
addpath([Str , 'Statistic']);

%% Result directory
%addpath([Str , 'Result']);

%% Problem directory
addpath([Str , 'Problem/' , ProblemName]);

end