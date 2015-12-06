function Xw = fourier_transform(Xt, w, t)

    %{
        Function used to obtain fourier transform of the signal

        Parameters
        ----------
        Xt : {vector}
            Signal that should be transformed
	 w : {array}
	    Range of frequencies to evaluate the fourier transform
	 t : {array}
	    Time range to evaluate the fourier transform integral
    %}

    %creates an array for the output of the function
    Xw = [];

    %{
	This loops through every omega frequency value passed in.
	We approximated the integration to be the sum of the products between the 		signal and the exponential and also multiplied it by dt which is 1/sampling 	frequency (16 kHz). This stores the real value of the signal in the output of 	the function.
    %}

    for i = w
        Xw = [Xw real(Xt * exp(-j*i*t)' * (1/16000))];
    end
              
end
