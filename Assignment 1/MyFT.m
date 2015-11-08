function Xw = MyFT(Xt, w, t)
    %using Fourier Pair analysis equation
    Xw = trapz(Xt*exp(-j*w*t), t) 
end
