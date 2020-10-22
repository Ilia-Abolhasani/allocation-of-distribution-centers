clc;
delete(timerfindall);
clear all;
close all;

i=1;
% t = timer('TimerFcn', 'stat=false; disp(''Timer!'')',... 
%                  'StartDelay',2);
t = timer('TimerFcn', 'i=i+1;start(t)',... 
                 'StartDelay',1);
start(t)

stat=true;
while(stat==true)
  disp(i)
  pause(0.1)
end