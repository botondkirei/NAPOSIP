iterations = 10000;
resolution = 10;
osc_gain = .1e9;
duty_cycle = .5;
F=1.05e9;
Fref = 10e6;
deltaF = osc_gain/(2^resolution);
F0 = 1e9;

cw = zeros(iterations,1);
for i=1:iterations-1
    cw(i+1) = cw(i) * (1-deltaF/Fref*duty_cycle) + (F-F0)/Fref*duty_cycle;
end
subplot(2,1,1)
plot(F0 + cw*deltaF)


cw = zeros(iterations,1);
noise  =  (rand (iterations,1)-.5);

cw = cw + noise;
for i=1:iterations-1
    cw(i+1) = cw(i+1) + cw(i) * (1-deltaF/Fref*duty_cycle) + (F-F0)/Fref*duty_cycle;
end
subplot(2,1,2)
%plot(F0 + cw(end*.75:end)*deltaF)
plot(F0 + cw*deltaF)