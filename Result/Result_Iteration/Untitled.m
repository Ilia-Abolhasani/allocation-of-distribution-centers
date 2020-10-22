clc
clear all
load('Data/HS.mat')
temp=zeros(28,3);
for i=1:28
temp(i,1)=min(Ans_HS(i,:));
temp(i,2)=mean(Ans_HS(i,:));
temp(i,3)=max(Ans_HS(i,:));
end
clearvars -except temp 
temp