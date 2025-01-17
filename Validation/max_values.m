clear all;
close all;

addpath('..');

c=3e8;

x0 = 0;
y0 = 0;
xf = 1;
yf = 1;

f = 1e9;

x_step = c/1e9/30; %Accuracy 1Ghz
%en-dessous de x_step = lambda/14 �a ne se propage plus

t0 = 0;
t_step = x_step/c/10; %Stability (1D condition)
tf = t0 + 1000*t_step;

x = x0:x_step:xf;
y = y0:x_step:yf;
t = t0:t_step:tf;

eps_rel = ones(length(y), length(x)); 
mu_rel = ones(length(y), length(x));



%Definition of the sources
sources = {};
sources{1} = [round(length(x)/2), round(length(y)/2), 1, 0];

outputs = computeFDTD(x,y,t,eps_rel,mu_rel, 'sources', sources, 'movie', 'none','special','verifConv');

sinE=sources{1}(3)*sin(2*pi*f*t + sources{1}(4));

maxiE=outputs.maxiE;
figure;plot(t,maxiE,'.');hold on;
plot(t,sinE);
title('Source amplitude and maximal values of the electric field')
legend('Maximal electric field value','Source amplitude');
xlabel('Time [s]');
ylabel('Amplitude [V/m]')