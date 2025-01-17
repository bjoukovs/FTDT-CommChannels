clear all;
close all;
clc;

addpath('..');
%% Beam forming

c=3e8;

x0 = 0;
y0 = 0;
xf = 2.5;%2.5*1;
yf = 2.5;%2.5*1;

f=1e9;%2.45e9;
x_step = c/f/30; %Accuracy 1Ghz
%en-dessous de x_step = lambda/14 �a ne se propage plus

t0 = 0;
t_step = x_step/c/10; %Stability (1D condition)
tf = t0 + 1250*t_step;

x = x0:x_step:xf;
y = y0:x_step:yf;
t = t0:t_step:tf;

eps_rel = ones(length(y), length(x));
mu_rel = ones(length(y), length(x));
mu_rel(floor(length(y)/2) - 5,floor(length(x)/2)-30:floor(length(x)/2)+30)= 5000;

lambda = c/f;
spacing=floor(lambda/4/x_step);
%delta for phi = 45�
%delta = sqrt(2)*pi/4;
%delta for phi = 180�
%delta = -2*pi/4;
% %delta for phi = 90�
% delta = 0;
phi = 90;%330;%20;%70;%250;90;
delta = (2*pi/lambda)*spacing*cos(deg2rad(phi));
x1 = round(length(x)/2) - 5*spacing;
y1 = round(length(y)/2);
% y1 = yf/2/x_step;
% x1 = xf/2/x_step;
% y1 = round(length(y)/2);
% x1 = round(length(x)/2);
nb_sources = 5;
sourca = zeros(nb_sources,2);

% for i=1:nb_sources
    
%sourca=[y1,x1];

for i = 1: nb_sources
    sourca(i,:) = [y1, x1 + spacing*i];
end

R=0.5;
[E, coupe_distance, coupe_temps, coupe_circulaire]=FDTD_compute_beam_forming(x,y,t,sourca,eps_rel,mu_rel,1,'',R,delta);

figure;plot(y,coupe_distance(1:end-1));title('Power density with y coordinate at a fixed time');
xlabel('Vertical coordinate y [m]');ylabel('Received power density [W/m^2]');
figure;plot(t,coupe_temps);
xlabel('Time [s]');ylabel('Received power density [W/m^2]');
vector_pi=linspace(-pi,pi,length(coupe_circulaire(:,2)));
figure;plot(coupe_circulaire(:,2),coupe_circulaire(:,1)) %TO ANALYZE
figure;plot(vector_pi,coupe_circulaire(:,1)) %TO ANALYZE
