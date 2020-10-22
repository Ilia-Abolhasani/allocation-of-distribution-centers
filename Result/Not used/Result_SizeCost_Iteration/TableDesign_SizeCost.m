LoadData();

%% Drew Table
LineWidth=1;
MarkerSize=7;
plot(Ans_AIA,'-o','LineWidth',LineWidth,'MarkerSize',MarkerSize);
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
title('Cost');
grid on
ax = gca;
ax.XTickLabel = {'10 * 10','10 * 20','15 * 15','10 * 30','50 * 50','30 * 100','50 * 200'};
