function Xw = MyFT(Xt, w, t)
    %frequency representation placeholder
   Xw = []

   %using Fourier Transform envelope property
   for k = -Inf:Inf
       wo = w/k

       To = 2*pi/wo

       Xw = [Xw MyFSAnalysis(Xt, t, k, wo)*To]
   end
end
