clc;
clear all;
close all;

% Intializing values
ac = 10;
fc = 200;
ts = 0.001;
ka = 0.3;
nlpf = 50;
bw = 150;

t = (0: ts : 0.5);
m = 2*cos(50*pi*t);
s = ac*(1 + ka*m) .* (cos(2*pi*fc*t));

% Fast fourier transform
nfft = length(t);
nfft = 2^ceil(log2(nfft)); % radix-2
f = ((-nfft/2) : (nfft/2)-1)/(nfft*ts);

% Message signal and modulated signal spectrum
M = fft(m,nfft);
M = fftshift(M);

S = fft(s, nfft);
S = fftshift(S);

subplot(3,1,2);
hold on;
plot(f, abs(M));
plot(f, abs(S));
hold off;
legend("|M|", "|S|");
title("Message and modulated signal spectrum");
xlabel("f");
ylabel("|M| || |S|");

% Message signal and modulated signal plot
subplot(3,1,1);
hold on;
plot(t,m);
plot(t,s);
hold off;
legend("m(t)", "s(t)");
title("Message signal and modulated signal");
xlabel("t");
ylabel("m(t) | s(t)");

% Demodulation
v = s .* cos(2*pi*fc*t);
h = fir1(nlpf, 2*bw*ts);
y = filter(h,1,v);

% Demodulated message signal
subplot(3,1,3);
hold on;
plot(t,m);
plot(t,y);
hold off;
legend("m(t)", "m1(t)");
title("Message signal and demodulated signal");
xlabel("t");
ylabel("m(t) | m1(t)");

sgtitle("Suhas KV | PES2UG20EC093");

% Envelope detection
figure(2);
ed = hilbert(s);
m1 = abs(ed);
subplot(3,1,2);
plot(t,[-1;1]*m1);
title("Envelope of modulated signal");
xlabel("t");
ylabel("s(t)");

% Envelope spectrum
E = fft(m1, nfft);
E = fftshift(E);

subplot(3,1,3);
plot(f, abs(E));
title("Spectrum of envelope of modulated signal");
xlabel("t");
ylabel("|E|");

% Demodulated signal spectrum
D = fft(y, nfft);
D = fftshift(D);

subplot(3,1,1);
plot(f,abs(D));
title("Spectrum of demodulated signal");
xlabel("t");
ylabel("|D|");


sgtitle("Suhas KV | PES2UG20EC093");