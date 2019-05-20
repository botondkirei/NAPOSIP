
N=8; %number of inverter cells in a column
m=[1e-9./[N:-1:1]; 1e-9./[N:-1:1]; 1e-9./[N:-1:1]]'; %drive strengths
r=[]; %frequencies for each codeword
for i=1:N
    for j=1:N
        for k=1:N
            r=[r 1/2/(m(i,1)+m(j,2)+m(k,3))];
        end
    end
end
subplot(1,1,1);
plot(r); hold on;

[rr,i]=sort(r);
%[r,i]=unique(r);
r=r(i);
plot(i,r); hold off;

