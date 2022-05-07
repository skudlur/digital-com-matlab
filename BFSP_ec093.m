%% Bit error rate for BFSK

clc;
close all;
clear;

N = 10^7;  % Number of random BPSK symbols to be generated

rng('default'); % Seed for rand generation

ip = rand(1,N) > 0.5;
s = 2 * ip-1;
n = 1/sqrt(2)*(randn(1,N)+1j*randn(1,N));
ebno = -4:2:10;

% Error count after extraction
for i = 1 : length(ebno)
    y = s+10^(-ebno(i)/20)*n;
    ipHat = real(y) > 0;
    nErr(i) = size(find(ip-ipHat),2);
end

% Theoretical and simulated bit error rates
s_ber = nErr/N;
t_ber = 0.5*erfc(sqrt(10.^(ebno/10))/2);

% Plots
figure(1);
semilogy(ebno, t_ber, 'b.-');
hold on;
semilogy(ebno, s_ber, 'mx-');
axis([-3 10 10^-5 0.5]);
grid on;

legend('Theoretical','Simulation');
xlabel('Eb/No in dB');
ylabel('BER rate');
title('Bit Error Rate for BFSK modulation');
