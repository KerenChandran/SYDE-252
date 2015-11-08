function z = MyiFT(wt,w,t)
    %{
            Parameters
            ----------
            x - signal; array representation
            t - time sample array
            k - particular coefficient to be determined
            wo - fundamental frequency of signal
        %}

    % time-domain sample array - 100ms samples between 1 and 3 seconds
    t = 0:0.1:3

    %arbitrary function x(t)
    x = 1+cos(2*pi*t)/4+cos(2*pi*t*2)/2 + cos(2*pi*t*3)/3;

    %specified fundamental frequency of x(t)
    wo = 2*pi

    comp = exp(-j*wo*k*t)
    %obtain index of time sample corresponding to element after one period
    ix_last = find(t==t(1)+t)

    %product vector used for integral
    prod = []

    for i=1 : length(x)
        prod = [prod x(i)*comp(i)]
    end

    % x(t) = 1/2pi * integral from -inf to +inf of X(w)e^jwot dw
    
    z = (1/(2*pi)) * trapz(prod(1:ix_last), t(1:ix_last))

end

