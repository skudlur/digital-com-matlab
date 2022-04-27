%% Power spectra of Discrete PAM signals

tr = 0.001;
rb = 100;
N = 1000000;
tb = 1/rb;
ton = tb/2;
bit_stream = round(rand(1,N)); % unipolar format (1, 0)
%bit_stream = randi(1,N);

Aindex = find(double(bit_stream));
Aindex = downsample(Aindex,2,1);
At(Aindex) = -1;

k = kron(bit_stream, Aindex);
