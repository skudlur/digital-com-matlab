%% This is a sampling theorem program

clc;
clear all;
close all;

ac = 10;
fc = 200; % Carrier frequency
ts = 0.001; % Sampling time

% LPF
nlp = 50;
bw = 150;

t = [-0.05 : ts : 0.25];
m = zeros(1,length(t));

m(t>=0 & t<0.1) = 10*t(t>=0 & t<0.1);
m(t>=0.1 & t<=0.2) = 10*(0.2 - t(t>=0.1 & t<=0.2));

subplot(3,2,1);
plot(t,m);
title("Message signal");
xlabel("t");
ylabel("m(t)");

% DSBSC signal

s = m .* (ac * cos(2*pi*fc*t));
subplot(3,2,2);
plot(t,s);
title("Modulated signal");
xlabel("t");
ylabel("s(t)");

% Discrete-time sampled signal

Nfft = length(t);

Nfft = 2^ceil(log2(Nfft)); % radix-2 

f = ((-Nfft/2) : (Nfft/2)-1)/(Nfft*ts);

% Plotting spectrum of m(t)

M = fft(m,Nfft);
M = fftshift(M);
subplot(3,2,3);
plot(f, abs(M));
title("DFT message signal");
xlabel("f");
ylabel("|M|")

% Plotting spectrum of s(t)

S = fft(s, Nfft);
S = fftshift(S);
subplot(3,2,4);
plot(f, abs(S));
title("DFT modulated signal");
xlabel("f");
ylabel("|S|");

% Demodulation

v = s .* cos(2*pi*fc*t);

% LPF 

h = fir1(nlp, 2*bw*ts);
m1 = filter(h,1,v);

% Plotting the demodulated signal

subplot(3,2,5);
plot(t, v);
title("Carrier signal")
xlabel("t");
ylabel("v(t)");

subplot(3,2,6);
plot(t, m1);
title("Demodulated singal");
xlabel("t");
ylabel("m1(t)");
