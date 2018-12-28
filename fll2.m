iterations = 10000;
resolution = 12;
osc_gain = .1e9;
duty_cycle = .5;
F=1.05e9;
Fref = 10e6;
deltaF = osc_gain/(2^resolution);
F0 = 1e9;

%cwr = zeros(iterations,1);
%for i=1:iterations-1
 %   cwr(i+1) = cwr(i) * (1-deltaF/Fref*duty_cycle) + (F-F0)/Fref*duty_cycle;
%end
%subplot(2,1,1)
%plot(F0 + cwr*deltaF)


%cw = zeros(iterations,1);
epsilon=1*randn(iterations,1);
ro = 2*(rand(iterations,1)-.5);

for i=1:iterations-1
    cw(i+1) = cw(i) * (1-deltaF/Fref*duty_cycle) + (F-F0)/Fref*duty_cycle -epsilon(i)*deltaF*duty_cycle/Fref/2^resolution - ro(i)*duty_cycle;
end
subplot(2,1,1)
%plot(F0 + cw(end*.75:end)*deltaF)
fosc=F0 + cw*deltaF;
plot(fosc)

jitter = abs(1/F-1/max(fosc(end*.7:end)))+abs(1/F-1/min(fosc(end*.7:end)))

cw = zeros(iterations,1);
epsilon=1.*epsilon;
ro = 1.*ro;
t=1-deltaF*duty_cycle/Fref;
t_vect = t.^(0:iterations-1)';
t_sum = 0;

for i=1:iterations-1
    t_sum=t_sum+t_vect(i);
    cw(i+1) = (F-F0)/Fref*duty_cycle*t_sum-deltaF*duty_cycle/Fref/2^resolution*sum(epsilon(1:i).*t_vect(i:-1:1))-duty_cycle*sum(ro(1:i).*t_vect(i:-1:1));
end
subplot(2,1,2)
plot(F0 + cw(end*.75:end)*deltaF)
fosc=F0 + cw*deltaF;
plot(fosc)

jitter = abs(1/F-1/max(fosc(end*.7:end)))+abs(1/F-1/min(fosc(end*.7:end)))
