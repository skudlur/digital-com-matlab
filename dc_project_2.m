%% Bit error rate for BPSK

eb = 1;
n = 10000000;
ebno = -4:2:10;

nv = (2.*ebno).^-1;
wn = wgn(n,1,0);

figure(1);
subplot(3,1,1);
plot(wn);

sn = randi([-1 1],n,1);
out = nrSymbolModulate(sn, 'BPSK');

subplot(3,1,2);
plot(sn);

subplot(3,1,3);
plot(out);
