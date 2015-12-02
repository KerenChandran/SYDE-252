function Xw = fourier_transform(Xt, w, t)
    Xw = [];

    for i = w
        Xw = [Xw real(Xt * exp(-j*i*t)' * (1/16000))];
    end
              
end
