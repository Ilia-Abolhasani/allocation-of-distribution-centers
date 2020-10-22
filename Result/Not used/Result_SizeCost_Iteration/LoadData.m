clc;
delete(timerfindall);
clear all;
close all;

%% SA
load('Data/SA.mat');
Ans_SA=Ans;
%% GA
load('Data/GA.mat');
Ans_GA=Ans;
%% KA
load('Data/KA.mat');
Ans_KA=Ans;
%% PSO
load('Data/PSO.mat');
Ans_PSO=Ans;
%% HS
load('Data/HS.mat');
Ans_HS=Ans;
%% AIA
load('Data/AIA.mat');
Ans_AIA=Ans;
%% GaSa
load('Data/GaSa.mat');
Ans_GaSa=Ans;
%% KaSa
load('Data/KaSa.mat');
Ans_KaSa=Ans;
