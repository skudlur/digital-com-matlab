%% Bit error rate for BPSK

eb = 1;
n = 10000000;
ebno = -4:2:10;

d = randi([0 1],n,1,'int8');
out = nrSymbolModulate(d, 'BPSK');
