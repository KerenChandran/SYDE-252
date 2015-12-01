function z = sound_analyze(x,hz)
    sample = [];
    [m,n] = size(x);
    j = 10;
    for i = 1:j:m
        signal = x(i,1);
        if signal >= 0.075
            sample = [sample signal]
        end
    end
    z = sample;
end
