clc;
close all;
clear all;
load('Data/SA01');
load('Data/GA01');
% load('Data/PSO01');
% load('Data/AIA01');
% load('Data/HS01');
load('Data/KA01');
% load('Data/GaSa01');
% load('Data/KaSa01');
%% Drew Table
LineWidth=1.2;
MarkerSize=7;
% plot(Ans_AIA,'-b','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_GA,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
hold on;
% plot(Ans_GaSa,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_HS,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_KA,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_KaSa,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
% plot(Ans_PSO,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
plot(Ans_SA,'-','LineWidth',LineWidth,'MarkerSize',MarkerSize);
xlabel('Iteration','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
ylabel('Cost','FontSize',9,'FontWeight','normal','FontName','Times New Roman','Color','k');
legend('GA','KA','SA')

