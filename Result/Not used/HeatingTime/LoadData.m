clc;
delete(timerfindall);
clear all;
close all;

%% SA
load('Data/SA.mat');
Ans_SA=Ans(:,1);

%% GA
load('Data/GA.mat');
Ans_GA=Ans
%% KA
load('Data/KA.mat');
Ans_KA=Ans(:,1);
%% PSO
load('Data/PSO.mat');
Ans_PSO=Ans(:,1);
%% HS
load('Data/HS.mat');
Ans_HS=Ans(:,1);
%% AIA
load('Data/AIA.mat');
Ans_AIA=Ans(:,1);
%% GaSa
load('Data/GaSa.mat');
Ans_GaSa=Ans(:,1);
%% KaSa
load('Data/KaSa.mat');
Ans_KaSa=Ans(:,1);
