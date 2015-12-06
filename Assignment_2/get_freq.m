function z = get_freq(transform, f)
    % Arguments are magnitude, frequency
    z = [];
    signal1 = [];
    signal2 = [];
    
    % Split freq into signal1 and signal2
    % This is where the two bands sit.
    % Ex. 650-1000 & 1170-1500
    
    % Row 1 = magnitude
    % Row 2 = frequency

    [m,n] = size(transform);
    for i = 1:1:n
        freq = f(i);
        if freq > 650 && freq < 1000
            signal1 = [signal1 [transform(i);freq]];
        elseif freq > 1170 && freq < 1500
            signal2 = [signal2 [transform(i);freq]];
        end
    end
    
    %Find the maximum magnitude and record the index
    [mag1,freq1] = max(signal1,[],2);
    [mag2,freq2] = max(signal2,[],2);
    
    % Index may not be precise due to noise and duplicates
    % so freqency will be mapped to the closest value
    value = int64(freq1(1));
    if signal1(2,value) > 900.00
        z = [941];
    elseif signal1(2,value) > 800.00
        z = [852];
    elseif signal1(2,value) > 740.00
        z = [770];
    else 
       z = [697];
    end
    
    value = int64(freq2(1));
    if signal2(2,value) > 1400.00
        z = [z 1477];
    elseif signal2(2,value) > 1280.00
        z = [z 1336];
    else 
       z = [z 1209];
    end
    
    % z is the output matrix containing two coloumns
    % of the freqencies found.
end