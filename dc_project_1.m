%% Pulse Shaping with Nyquist pulses

clear;
close all;
clc;

rb = 100; % bitrate in hertz
tb = 1/rb;
tmax = 10*tb;
tr = 0.001;
alpha = 0;
t = [-0.05 : tr : 0.05];

p(t>=tmax & t<=tmax) = (sinc(rb.*t).*cos(pi.*alpha.*rb.*t))/1-(4.*(alpha^2).*(rb^2).*(t^2));

pf = laplace(p);

figure(1);
subplot(3,2,1);
plot(t,p);
title("Raised cosine spectrum");
xlabel("t");
ylabel("T");