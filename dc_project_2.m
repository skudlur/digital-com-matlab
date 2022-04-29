%% Bit error rate for BPSK

eb = 1;
n = 1000;
ebno = -4:2:10;

nv = (2.*ebno).^-1;
wn = wgn(n,1,0);

figure(1);
plot(wn);

d = randi([0 1],n,1,'int8');
out = nrSymbolModulate(d, 'BPSK');
