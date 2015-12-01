function Dt = DialTone(acqData)
    %{
        Function used to obtain correct numeric representation of the 
        prescribed dial tone.

        Parameters
        ----------
        acqData : {matrix}
            2-dimensional matrix of size n * 2 where n represents the number of
            sampled data points; matrix column represents left or right speaker 
    %}

    %store matrix representation of dial-tone linear frequency combinations
    dt_comb = py.dict(pyargs(
        '1', py.tuple(697, 1209),  
        '2', py.tuple(697, 1336),  
        '3', py.tuple(697, 1477),   
        '4', py.tuple(770, 1209),  
        '5', py.tuple(770, 1336),  
        '6', py.tuple(770, 1477),  
        '7', py.tuple(852, 1209),  
        '8', py.tuple(852, 1336),  
        '9', py.tuple(852, 1477),   
        '*', py.tuple(941, 1209),  
        '0', py.tuple(941, 1336),  
        '#', py.tuple(941, 1477)  
    ));

    %provided sampling frequency
    freq = 16*10^3;

    %strictly consider data obtained from one signal
    left_speaker = acqData(:, 1);

    %obtain correct sampling array using provided sampling frequency
    t_samp = 0:1/freq:length(left_speaker)-1;

    %if required to play the dial tone, using the following code
    %sound(left_speaker, freq)

    %{
        plotting the dial tone, as displayed in the supplementary report,
        presents a signal consisting of distinct tones and arbitrary noise.
        based on the signal, it was determined that the noise of the signal
        (in the time domain) did not exceed an amplitude of 0.05. Therefore
        individual dial tones were separated and placed into an overarching 
        matrix.
    %}
    
    %until we find way to dynamically resize array, preallocate
    dt_arr = zeros(1, 11);

    %array beginning placeholder
    beg = 1;

    %iterate through all data points, separating dial tones
    while beg <= length(left_speaker)
        lower_bound = beg
        upper_bound = beg
        
        %iterate through all points and find upper and lower bound of dial tone
        for pt = beg:length(left_speaker)
            if pt > 0.05 and lower_bound == beg
                lower_bound = pt
            elseif pt < 0.05 and lower_bound ~= beg
                upper_bound = pt - 1
                break
        end

        %sub_vector
        dt_sub = left_speaker(lower_bound, upper_bound)

        %apply fourier transformation on sub_vector and obtain peaks
        %insert function/code snippet here

        %for now assume peak frequencies returned as tuples
        dt_idx = 0

        for idx = 1:length(values(dt_comb))
            if peak_freq = values(dt_comb)(idx)
                dt_idx = idx
        end

        %error check - proceed to next dial tone in case of failure
        if dt_idx = 0
            continue

        %double check syntax for indexing values array
        dt_arr = [dt_arr keys(dt_comb)(dt_idx)]
    end

    %return array of dial tone representations
    Dt = dt_arr
end

