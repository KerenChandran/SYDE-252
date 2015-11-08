%
% script to calculate fourier series coefficient, ak
%

% time-domain sample array - 100ms samples between 1 and 3 seconds
t = 0:0.1:3

%arbitrary function x(t)
x = 1+cos(2*pi*t)/4+cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;

%specified fundamental frequency of x(t)
wo = 2*pi

%specified k value
k = 1

%complex exponential 
comp = exp(-j*wo*k*t);

%calculated period 
T = 2*pi/wo

%return index of element representing time after 1 period 
ix_last = find(t==t(1) + T)

prod = []

for i:length(x):
    prod = [prod x(i)*comp(i)]
end

%compute ak 
ak = (1/T)*trapz(prod, t)

ak = real(ak)


