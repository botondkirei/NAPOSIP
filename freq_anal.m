
G=1e-7
KVCO=1e8
omega = 0:0.1:pi;
z=e.^(j*omega)
ro=z./(z-0.5)
h=G*KVCO*(ro-.5).*z.^-1./(1+G*KVCO*z.^-1)
plot(omega,abs(h))
