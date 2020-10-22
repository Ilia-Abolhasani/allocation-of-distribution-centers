clc;
clear all;
close all;
%% Add path & Address manage
addpath('../../.');
AddPaths('../.././','allocation4DC');
%%
LoadData;
% Ans_AIA=Convert28to7(Ans_AIA);
% Ans_HS=Convert28to7(Ans_HS);
Ans_GA=Convert28to7(Ans_GA);
% Ans_GaSa=Convert28to7(Ans_GaSa);
% Ans_KaSa=Convert28to7(Ans_KaSa);
Ans_KA=Convert28to7(Ans_KA);
% Ans_PSO=Convert28to7(Ans_PSO);
Ans_SA=Convert28to7(Ans_SA);
%% SA
SA=zeros(1,3);
SA(1)=min(Ans_SA);
SA(2)=mean(Ans_SA);
SA(3)=max(Ans_SA);
%% GA
GA=zeros(1,3);
GA(1)=min(Ans_GA);
GA(2)=mean(Ans_GA);
GA(3)=max(Ans_GA);
%% GaSa
% GaSa=zeros(1,3);
% GaSa(1)=min(Ans_GaSa);
% GaSa(2)=mean(Ans_GaSa);
% GaSa(3)=max(Ans_GaSa);
%% KA
KA=zeros(1,3);
KA(1)=min(Ans_KA);
KA(2)=mean(Ans_KA);
KA(3)=max(Ans_KA);
%% KaSa
% KaSa=zeros(1,3);
% KaSa(1)=min(Ans_KaSa);
% KaSa(2)=mean(Ans_KaSa);
% KaSa(3)=max(Ans_KaSa);
%% PSO
% PSO=zeros(1,3);
% PSO(1)=min(Ans_PSO);
% PSO(2)=mean(Ans_PSO);
% PSO(3)=max(Ans_PSO);
%% AIA
% AIA=zeros(1,3);
% AIA(1)=min(Ans_AIA);
% AIA(2)=mean(Ans_AIA);
% AIA(3)=max(Ans_AIA);
%% HS
% HS=zeros(1,3);
% HS(1)=min(Ans_HS);
% HS(2)=mean(Ans_HS);
% HS(3)=max(Ans_HS);

%% Drew Table
LineWidth=1.2;
MarkerSize=7;

X=[1,2,3];
Mean=[GA(2),KA(2),SA(2)];
Min=[GA(1),KA(1),SA(1)];
Max=[GA(3),KA(3),SA(3)];
%%
% errorbar(1,AIA(2),AIA(1),AIA(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
errorbar(1,GA(2),GA(1),GA(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
hold on;
% errorbar(3,GaSa(2),GaSa(1),GaSa(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% errorbar(4,HS(2),HS(1),HS(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
errorbar(2,KA(2),KA(1),KA(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% errorbar(6,KaSa(2),KaSa(1),KaSa(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% errorbar(7,PSO(2),PSO(1),PSO(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
errorbar(3,SA(2),SA(1),SA(3),'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
%%

xlabel('Algorithm','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
ylabel('RPD','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
title('GAP','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
ax = gca;
ax.XTickLabel = {' ' ,'GA',' ','KA',' ','SA',' '};