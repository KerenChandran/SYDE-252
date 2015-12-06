function m = mapping(freq)
   %{
        Function used to obtain dail tones

        Parameters
        ----------
        freq : {array}
            Array containing two frequencies; first being the lower frequency, second 	     being the larger frequency
    %}

    %Stores all possible dial tones in a 2D array
    dial_tones = ['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#'];

    %Initializes the row and column values to be -1
    i = -1;
    j = -1;

    %Uses the first frequency to retrieve the appropriate row to check
    switch(freq(1))
        case 697
            i = 1;
        case 770
            i = 2;
        case 852
            i = 3;
        case 941
            i = 4;
    end

    %Uses the second frequency to retrieve the appropriate column to check
    switch(freq(2))
        case 1209
            j = 1;
        case 1336
            j = 2;
        case 1477
            j = 3;
    end
    
    %Retrieves the number that was pressed based on the row and column vector that 
    matched the frequency 
    m = dial_tones(i,j);

end