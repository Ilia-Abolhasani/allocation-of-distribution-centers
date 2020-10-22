clc;
clear all;
close all;
LoadData();
%% SA
SA=zeros(1,2);
SA(1)=mean([min(Ans_SA) max(Ans_SA)]);
SA(2)=max(Ans_SA)-SA(1);
%% GA
GA=zeros(1,2);
GA(1)=mean([min(Ans_GA) max(Ans_GA)]);
GA(2)=max(Ans_GA)-GA(1);

%% GaSa
GaSa=zeros(1,2);
GaSa(1)=mean([min(Ans_GaSa) max(Ans_GaSa)]);
GaSa(2)=max(Ans_GaSa)-GaSa(1);

%% KA
KA=zeros(1,2);
KA(1)=mean([min(Ans_KA) max(Ans_KA)]);
KA(2)=max(Ans_KA)-KA(1);
%% KaSa
KaSa=zeros(1,2);
KaSa(1)=mean([min(Ans_KaSa) max(Ans_KaSa)]);
KaSa(2)=max(Ans_KaSa)-KaSa(1);
%% PSO
PSO=zeros(1,2);
PSO(1)=mean([min(Ans_PSO) max(Ans_PSO)]);
PSO(2)=max(Ans_PSO)-PSO(1);
%% AIA
AIA=zeros(1,2);
AIA(1)=mean([min(Ans_AIA) max(Ans_AIA)]);
AIA(2)=max(Ans_AIA)-AIA(1);
%% HS
HS=zeros(1,2);
HS(1)=mean([min(Ans_HS) max(Ans_HS)]);
HS(2)=max(Ans_HS)-HS(1);

%% Drew Table
LineWidth=1;
MarkerSize=7;

X=[1,2,3,4,5,6,7,8];
y=[AIA(1),GA(1),GaSa(1),HS(1),KA(1),KaSa(1),PSO(1),SA(1)];
e=[AIA(2),GA(2),GaSa(2),HS(2),KA(2),KaSa(2),PSO(2),SA(2)];
errorbar(X,y,e,'bd','LineWidth',LineWidth,'MarkerSize',MarkerSize);
xlabel('Algorithm','FontSize',12,'FontWeight','bold','Color','r');
ylabel('RPD','FontSize',12,'FontWeight','bold','Color','r');
title('GAP');
ax = gca;
ax.XTickLabel = {' ' ,'AIA','GA','GaSa','HS','KA','KaSa','PSO','SA'};