function z = MyiFT(wt,w,t)
%{
    Parameters
    ----------
    wt - signal; array representation
    t - time sample array
    wo - fundamental frequency of signawt
    %}

comp = exp(j*w*t)

%product vector used for integral
prod = []

for i = 1 : length(wt)
prod = [prod wt(i) * comp(i)]
end

% x(t) = 1/2pi * integral from -inf to +inf of X(w)e^jwot dw

z = (1/(2*pi)) * trapz(prod, t)

end