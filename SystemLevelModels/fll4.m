
rect = @(t,x,y) heaviside(t-x+y/2)-heaviside(t-x-y/2);
xt = @(t,Fref,n,f) rect(t,(n+.5)/Fref,1/Fref)*sin(2*pi*f*t);

Fref = 10e6; 
f=[100e6 200e6 150e6 ];
%f=100e6;
N=length(f);
t=linspace(0,N/Fref,N*1000);
x=[];
for j=0:N-1
    for i=1:1000
        x = [x xt(t(i+j*1000),Fref,j,f(j+1))];
    end
end
plot(abs(fftshift(fft(x))));