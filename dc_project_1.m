%% Pulse Shaping with Nyquist pulses

clear;
close all;
clc;

% Parameters
rb = 100; % bitrate in hertz
tb = 1/rb;
tmax = 10*tb;
tr = 0.001;
alpha = 0;
t = -0.05 : tr : 0.05;

% Raised Cosine Pulse
p = (sinc(rb.*t).*cos(pi.*alpha.*rb.*t))/1-(4.*alpha.^2.*rb.^2.*t.^2);

%p = (sinc(rb.*t)).^2; % sinc^2

% Frequency Spectrum
nfft = length(t);
nfft = 2^ceil(log2(nfft));
f = ((-nfft/2):(nfft/2)-1)/(nfft*tb);
f1 = fft(p,nfft);
f1 = fftshift(f1);

% Plotting spectrum
figure(1);
sgtitle("Pulse Shaping with Nyquist Pulses");
subplot(2,1,1);
plot(t,p);
title("Raised cosine spectrum");
xlabel("Time");
ylabel("Amplitude");

subplot(2,1,2);
plot(f,f1);
title("Frequency spectrum");
xlabel("Frequency");
ylabel("Amplitude");
