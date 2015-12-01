function Xw = fourier_transform(Xt, w, t)
    Xw = [];

    for i = w
        y = exp(-j*i*t)
        Xw = [Xw norm(trapz(t, Xt * y.'))]
    end
end