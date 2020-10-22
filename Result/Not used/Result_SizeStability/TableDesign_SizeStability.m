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

%% Drew Table
LineWidth=1.5;
MarkerSize=15;

p=plot(Ans_AIA,'-o','LineWidth',LineWidth,'MarkerSize',MarkerSize);
hold on;
plot(Ans_GA,'-+','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_GaSa,'-x','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_HS,'-d','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_KA,'-v','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_KaSa,'-^','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_PSO,'-<','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_SA,'->','LineWidth',LineWidth,'MarkerSize',MarkerSize);
xlabel('size','FontSize',12,'FontWeight','bold','Color','r');
ylabel('cost','FontSize',12,'FontWeight','bold','Color','r');
legend('AIA','GA','GaSa','HS','KA','KaSa','PSO','SA')
title('Stability');
grid on
ax = gca;
ax.XTickLabel = {'10 * 10','10 * 20','15 * 15','10 * 30','50 * 50','30 * 100','50 * 200'};