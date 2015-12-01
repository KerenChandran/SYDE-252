function Xw = MyFT(Xt, w, t)
    %frequency representation placeholder
   Xw = []

   %{
    Arbitrary bound was chosen for the loop representing different values of w.
    Using different values of w, one can obtain different frequency values.
   %}

   %using Fourier Transform Analysis equation 
   for w = 0 : t(end):
        Xw = trapz(Xt*exp(-j*w*t), t)
   end 

   %{
   %using Fourier Transform envelope property
   for k = -Inf:Inf
       wo = w/k

       To = 2*pi/wo

       Xw = [Xw MyFSAnalysis(Xt, t, k, wo)*To]
   end
   %}
end
