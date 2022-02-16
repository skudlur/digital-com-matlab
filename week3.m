% Program to get power spectra of WSS processes
clc;
clear;
close all;

%% Gaussian white noise process

m = 0; % mean value
v = 1; % variance value

N = 1000; % Sample length 1 

rng(0,'v4'); % rng to get a random seed for white noise
tem = v.*randn(N,1) + m; % Gaussian white noise for N

figure(1);
subplot(3,1,1);
plot(tem);
grid on;
xlabel('n');
ylabel('X(n)');
title('Gaussian white noise process X(n)');

%% Autocorrelation

ra = -10:10;
[ac,lags] = xcorr(tem,'normalized'); % Autocorrelation term
subplot(3,1,2);
plot(lags, ac);
xlabel('k');
ylabel('Rx(k)');
title('Autocorrelation with normalisation');

%% Power spectrum

sx = fft(ac, 512);
sx = fftshift(sx);
subplot(3,1,3);
pirange = -pi:0.01229:pi; % 2pi/512 for the increment term
stem(pirange,abs(sx));
xlabel('e^jw');
ylabel('Sx(e^jw)');
title('Power spectrum density');

%% AR(1) process 

alp = 0.9;
ar = NaN*ones(N,1);
for t = 1:N
    ar(t+1) = alp.*ar(t) + randn(1);
end

ar1 = normalize(xcorr(ar));

arfft = fft(ar1,512);
arfft = fftshift(arfft);

figure(2);
subplot(3,1,1);
plot(arfft);
xlabel('n');
ylabel('Y(n)');
title('AR(1) process');

% Normalized autocorrelation of AR(1) process

rar = -10:10;
[acar,lags2] = xcorr(tem,'normalized'); % Autocorrelation term
subplot(3,1,2);
plot(lags2, acar);
xlabel('k');
ylabel('Ry(k)');
title('Autocorrelation with normalisation');

% Power density spectrum for AR(1)

sy = fft(ac, 512);
sy = fftshift(sy);
subplot(3,1,3);
pirange = -pi:0.01229:pi; % 2pi/512 for the increment term
stem(pirange,abs(sy));
xlabel('e^jw');
ylabel('Sy(e^jw)');
title('Power spectrum density');