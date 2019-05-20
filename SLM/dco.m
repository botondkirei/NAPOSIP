function [r] = dco(N)
%N=8; number of inverter cells in a column
m=[1e-9./[N:-1:1]; 1e-9./[N:-1:1]; 1e-9./[N:-1:1]]'; %drive strengths
r=[]; %frequencies for each codeword
for i=1:N
    for j=1:N
        for k=1:N
            r=[r 1/2/(m(i,1)+m(j,2)+m(k,3))];
        end
    end
end
%r=floor((r));
%[rr,i]=sort(r);
%r=r(i);
endfunction
