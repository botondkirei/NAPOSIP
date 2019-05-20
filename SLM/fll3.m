k=1000;
R = 5:20;
osc_gain = .1e9;
D = .5;
Fdes=1.05e9;
Fref = 10e6;
deltaF = osc_gain./(2.^R);
F0 = 1e9;

#jit=abs(1/Fdes-1./(Fdes+(2.^(-R)+1).*Fref./D))+...
#abs(1/Fdes-1./(Fdes-(2.^(-R)+1).*Fref./D));

jit = abs(1/Fdes-1./(Fdes+4*deltaF))+abs(1/Fdes-1./(Fdes-4*deltaF));

semilogy(R,jit/1e-12)
#sqnr = 6.02*R;
#20*log10((Fdes/Fref*D)/noise)=6.02*R;
#noise=10^(6.02*R/10)*Fref/Fdes/D;

#n1 =  rand(k,1);
#n2 =  rand(k,1);
k=1000;

p=.9;
g=.5;
pp=p.^((0:k-1)');
s=[];
for i=1:2000 
    noise = 2*rand(k,1)-1;
    s=[s sum(noise.*pp)];
end
#hist(s,30)
#g/(1-p)

#R=5:20;
#Fdes=1.05e9;
#Fref=10e6;
#D=.5;
#jitter = abs(1/Fdes .- 1./(Fdes+(2.^(-(R+1))-1/2)*Fref/D))