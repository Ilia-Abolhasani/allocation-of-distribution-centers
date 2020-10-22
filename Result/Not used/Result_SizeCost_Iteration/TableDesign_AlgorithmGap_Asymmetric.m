clc;
clear all;
close all;
LoadData();
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
GaSa=zeros(1,3);
GaSa(1)=min(Ans_GaSa);
GaSa(2)=mean(Ans_GaSa);
GaSa(3)=max(Ans_GaSa);
%% KA
KA=zeros(1,3);
KA(1)=min(Ans_KA);
KA(2)=mean(Ans_KA);
KA(3)=max(Ans_KA);
%% KaSa
KaSa=zeros(1,3);
KaSa(1)=min(Ans_KaSa);
KaSa(2)=mean(Ans_KaSa);
KaSa(3)=max(Ans_KaSa);
%% PSO
PSO=zeros(1,3);
PSO(1)=min(Ans_PSO);
PSO(2)=mean(Ans_PSO);
PSO(3)=max(Ans_PSO);
%% AIA
AIA=zeros(1,3);
AIA(1)=min(Ans_AIA);
AIA(2)=mean(Ans_AIA);
AIA(3)=max(Ans_AIA);
%% HS
HS=zeros(1,3);
HS(1)=min(Ans_HS);
HS(2)=mean(Ans_HS);
HS(3)=max(Ans_HS);

%% Drew Table
LineWidth=1;
MarkerSize=7;

X=[1,2,3,4,5,6,7,8];
Mean=[AIA(2),GA(2),GaSa(2),HS(2),KA(2),KaSa(2),PSO(2),SA(2)];
Min=[AIA(1),GA(1),GaSa(1),HS(1),KA(1),KaSa(1),PSO(1),SA(1)];
Max=[AIA(3),GA(3),GaSa(3),HS(3),KA(3),KaSa(3),PSO(3),SA(3)];
errorbar(X,Mean,Min,Max,'rd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
xlabel('Algorithm','FontSize',12,'FontWeight','bold','Color','r');
ylabel('RPD','FontSize',12,'FontWeight','bold','Color','r');
title('GAP');
ax = gca;
ax.XTickLabel = {' ' ,'AIA','GA','GaSa','HS','KA','KaSa','PSO','SA'};