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
%% Drew Table
LineWidth=1;
MarkerSize=7;

% p=plot(Ans_AIA,'-o','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_GA,'-+','LineWidth',LineWidth,'MarkerSize',MarkerSize);
hold on;
% plot(Ans_GaSa,'-x','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_HS,'-d','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_KA,'-o','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_KaSa,'-^','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_PSO,'-<','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_SA,'->','LineWidth',LineWidth,'MarkerSize',MarkerSize);
xlabel('Size','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
ylabel('Cost','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
legend('GA','KA','SA')
title('Stability','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
grid on
ax = gca;
ax.XTickLabel = {'10 * 10','10 * 20','15 * 15','10 * 30','50 * 50','30 * 100','50 * 200'};