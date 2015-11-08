%{
  Script used to reconstruct x(t) using fourier series coefficients  
%}

%specified original signal
x = 1+cos(2*pi*t)/4+cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3

%specified sampling interval
t = 0:0.1:3

%specified fundamental frequency
wo = 2*pi

%reconstructed x(t) placeholder
x_rec = []

for k = -Inf : Inf
    x_rec = [x_rec MyFSAnalysis(x, t, k, wo)*exp(-j*wo*k*t)]
end