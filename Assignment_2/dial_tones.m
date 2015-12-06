function d = dial_tones(acqData)
    %{
        Function used to obtain dail tones

        Parameters
        ----------
        acqData : {vector}
            Signal containing the dialtones that user wants to decode
    %}

    % Takes one channel of the signal to get the dial tones.
    % Assumes dial tones are in left or both channels
    left_speaker = acqData(:,1);
    
    %This value is used to get the upper bound of the dial_tone
    sample_length = 3000;
    
    %Array containing angular frequencies that should be passed into
    %fourier_transform
    w = 0:2*pi*2000;
    
    %Converts Angular frequency array into frequency values and matches
    %length to w
    f = 0:2000/(length(w)-1):2000;
    
    %Array to store dial_tone values
    dt_arr = [];

    %Counter that keeps track how far we are in the original signlal
    pt = 1;

    %Stores the length of the dial_tone signal in terms of indicies
    speaker_length = length(left_speaker);
    
    %iterate through all points and find upper and lower bound of dial tone
    while(pt < speaker_length)
        
        %{
            plotting the dial tone, as displayed in the supplementary report,
            presents a signal consisting of distinct tones and arbitrary noise.
            based on the signal, it was determined that the noise of the signal
            (in the time domain) did not exceed an amplitude of 0.05.
        %}
        
        if (left_speaker(pt) > 0.05)
            %Records lower bound
            lower_bound = pt;
            
            %Calculates appropriate upper bound to be passed into the
            %fourier transform function
            upper_bound = lower_bound + sample_length;
            if(speaker_length - pt < sample_length)
                upper_bound = lower_bound + speaker_length;
            end
            
            %Retrieves the single dial tone and stores it
            signal = left_speaker(lower_bound:upper_bound);
            
            %Retrieves fourier transform of the signal
            transform = fourier_transform(signal', w, (0:length(signal)-1)/16000);
           
            %{
                Scans fourier transform sampled signal and retrieves highest
            	frequency values, which is then passed to get mapping to get
            	the appropriate dial tone. This dial tone is then stored in
            	the dt_array
            %}
            dt_arr = [dt_arr mapping(get_freq(transform, f))];
            
            %Sets index of current signal to be equal to upper bound to
            %avoid repeating dial tones
            pt = upper_bound;
            
        %Increments index counter if the amplitude of the point of the
        %signal is below the threshold (0.05)
        else
            pt = pt + 1;
        end
    end
    
    %Outputs the dial tones of the entire signal
    d = dt_arr;

end