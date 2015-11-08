function x_rec = MySignalReconstruction(x,t,wo)

    %{
      Script used to reconstruct x(t) using fourier series coefficients  
    %}

    %reconstructed x(t) placeholder
    x_rec = []

    for k = -Inf : Inf
        x_rec = [x_rec MyFSAnalysis(x, t, k, wo)*exp(-j*wo*k*t)]
    end
end