% Program to sample a signal and reconstruct it using IFFT
clc;
clear;
close all;
% Constants defined
tr = 0.001;
Ts = 0.02;
t = [0:tr:1];

% Plotting x(t)

xt = cos(2*pi*t) + 2*sin(4*pi*t);
subplot(2,2,1);
grid on;
plot(t,xt);
xlabel('t');
ylabel('Input signal x(t)');
title('x(t) plot');

% Ideal sampling function
I = zeros(size(xt));
N = Ts/tr;
n = [0:N:1];

I(1:N:end) = 1; % Ones set to the Nth index
Xs = xt .* I;
subplot(2,2,2);
grid on;
stem(t,Xs);
xlabel('t');
ylabel('X(s)');
title('Sampled signal');

% Spectrum of x(t)
Xf1 = fft(xt, length(t));
Xf1 = fftshift(Xf1);
subplot(2,2,3);
plot(t,abs(Xf1));
xlabel('f');
ylabel('X(f)');
title('Spectrum of x(t)');

% Spectrum of X(s)
Xf2 = fft(Xs, length(t));
Xf2 = fftshift(Xf2);
subplot(2,2,4);
plot(t,abs(Xf2));
xlabel('f');
ylabel('X(f)');
title('Spectrum of X(s)');

% Low pass filter
bw = 10;
nlp = 50;
h = fir1(nlp,2*bw*Ts);
mm = filter(h,1,Xf2);

L = linspace(0,1,N);
mul = mm .* Xf2;
figure(2);
plot(t,mul);
