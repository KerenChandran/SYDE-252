function m = mapping(freq)

    dial_tones = ['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#'];

    f1 = freq(1);
    f2 = freq(2);

    i = 0;
    j = 0;

    switch(f1)
        case 697
            i = 1;
        case 770
            i = 2;
        case 852
            i = 3;
        case 941
            i = 4;
    end

    switch(f2)
        case 1209
            j = 1;
        case 1336
            j = 2;
        case 1477
            j = 3;
    end
    
    m = dial_tones(i,j);

end