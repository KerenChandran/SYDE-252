function ak = MyFSAnalysis(x, t, k, wo)
    %{
        Parameters
        ----------
        x - signal; array representation
        t - time sample array
        k - particular coefficient to be determined
        wo - fundamental frequency of signal
    %}

    %signal period 
    T = 2*pi/wo

    %complex exponential 
    comp = exp(-j*wo*k*t)

    %obtain index of time sample corresponding to element after one period
    ix_last = find(t==t(1)+T)

    %product vector used for integral
    prod = []

    for i=1 : length(x)
        prod = [prod x(i)*comp(i)]
    end

    ak = (1/T) * trapz(prod(1:ix_last), t(1:ix_last))
end