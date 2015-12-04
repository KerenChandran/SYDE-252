function d = dial_tones(acqData)
    left_speaker = acqData(:,1);
    sample_length = 3000;
    w = 0:2*pi*2000;
    
    dt_arr = [];
    pt = 1;
    speaker_length = length(left_speaker);
    
    %iterate through all points and find upper and lower bound of dial tone
    while(pt < speaker_length)
        if left_speaker(pt) > 0.05
            lower_bound = pt;
            upper_bound = lower_bound + sample_length;
            if(speaker_length - pt < sample_length)
                upper_bound = lower_bound + speaker_length;
            end
            signal = left_speaker(lower_bound:upper_bound);
            f = 0:2000/(length(w)-1):2000;
            transform = fourier_transform(signal', w, (0:length(signal)-1)/16000);
            dt_arr = [dt_arr mapping(get_freq(transform, f))];
            pt = upper_bound;
        else
            pt = pt + 1;
        end
    end

   d = dt_arr;

end