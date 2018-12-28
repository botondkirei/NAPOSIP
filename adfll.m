disp("All-Digital Frequency Locked loop");

Iterations = 30; 
Fref=10e6;
Fdes=6e8;
Hf=dco(8);
%calibrate
cal = round(Hf/Fref);
[dummy,lut]=sort(cal);
M = round(Fdes/Fref);

CW = 1;
CWv =[];
Fosc=[Hf(lut(M))]; %oscillation frequency;
for i = 1:Iterations 
    error = M - round(Fosc(end)/Fref);
    CWv = [CWv CW];
    CW = max(min(CW + error,512),1);
    Fosc = [Fosc , Hf(lut(CW))];
end
subplot(2,1,1);
plot(Fosc)
subplot(2,1,2);
plot(CWv)
