function [Ft, Ffrq,Fdwt] = Extract_Feature_Signal(x,c)
    

v = x(c:2*c);
vref = x(1:c-1);
    
f11 = norm(v)^2/norm(vref)^2;
f12 = mean(v)/mean(vref);
f13 = std(v)/std(vref);
f14 = skewness(v)/skewness(vref);
f15 = kurtosis(v)/kurtosis(vref);
f16 = max(v)/max(vref);
Ft = [f11;f12;f13;f14;f15;f16];


V = fft(v);
L = length(v);
E = abs(V)/L;
Ehalf = E(1:floor(L/2)+1);

Vref = fft(vref);
L = length(vref);
E = abs(Vref)/L;
Ehalfref = E(1:floor(L/2)+1);

f20 = norm(Ehalf)^2/norm(Ehalfref)^2;
f21 = mean(Ehalf)/mean(Ehalfref);
f22 = std(Ehalf)/std(Ehalfref);
f23 = skewness(Ehalf)/skewness(Ehalfref);
f24 = kurtosis(Ehalf)/kurtosis(Ehalfref);
f25 = max(Ehalf)/max(Ehalfref);
Ffrq = [f20;f21;f22;f23;f24;f25]; 
 
[c,l] = wavedec(v,5,'db4');
a5 = appcoef(c,l,'db4');
[cd1,cd2,cd3,cd4,cd5] = detcoef(c,l,[1 2 3 4 5]);

[c,l] = wavedec(vref,5,'db4');
a5_ref = appcoef(c,l,'db4');
[cd1_ref,cd2_ref,cd3_ref,cd4_ref,cd5_ref] = detcoef(c,l,[1 2 3 4 5]);

% figure()
% plot(cd1,'-r','LineWidth',2)
% hold on
% plot(cd1_ref,'.b','LineWidth',2)

f31 = norm(a5)^2/norm(a5_ref)^2;
f32 = norm(cd1)^2/norm(cd1_ref)^2;
f33 = norm(cd2)^2/norm(cd2_ref)^2;
f34 = norm(cd3)^2/norm(cd3_ref)^2;
f35 = norm(cd4)^2/norm(cd4_ref)^2;
f36 = norm(cd5)^2/norm(cd5_ref)^2;
f37 = mean(a5)^2/mean(a5_ref)^2;
f38 = mean(cd1)^2/mean(cd1_ref)^2;
f39 = mean(cd2)^2/mean(cd2_ref)^2;
f310 = mean(cd3)^2/mean(cd3_ref)^2;
f311 = mean(cd4)^2/mean(cd4_ref)^2;
f312 = mean(cd5)^2/mean(cd5_ref)^2;
f313 = std(a5)^2/std(a5_ref)^2;
f314 = std(cd1)^2/std(cd1_ref)^2;
f315 = std(cd2)^2/std(cd2_ref)^2;
f316 = std(cd3)^2/std(cd3_ref)^2;
f317 = std(cd4)^2/std(cd4_ref)^2;
f318 = std(cd5)^2/std(cd5_ref)^2;
f319 = skewness(a5)^2/skewness(a5_ref)^2;
f320 = skewness(cd1)^2/skewness(cd1_ref)^2;
f321 = skewness(cd2)^2/skewness(cd2_ref)^2;
f322 = skewness(cd3)^2/skewness(cd3_ref)^2;
f323 = skewness(cd4)^2/skewness(cd4_ref)^2;
f324 = skewness(cd5)^2/skewness(cd5_ref)^2;
f325 = kurtosis(a5)^2/kurtosis(a5_ref)^2;
f326 = kurtosis(cd1)^2/kurtosis(cd1_ref)^2;
f327 = kurtosis(cd2)^2/kurtosis(cd2_ref)^2;
f328 = kurtosis(cd3)^2/kurtosis(cd3_ref)^2;
f329 = kurtosis(cd4)^2/kurtosis(cd4_ref)^2;
f330 = kurtosis(cd5)^2/kurtosis(cd5_ref)^2;
f331 = max(a5)^2/max(a5_ref)^2;
f332 = max(cd1)^2/max(cd1_ref)^2;
f333 = max(cd2)^2/max(cd2_ref)^2;
f334 = max(cd3)^2/max(cd3_ref)^2;
f335 = max(cd4)^2/max(cd4_ref)^2;
f336 = max(cd5)^2/max(cd5_ref)^2;

Fdwt = [f31;f32;f33;f34;f35;f36;...
        f37;f38;f39;f310;f311;f312;...
        f313;f314;f315;f316;f317;f318;...
        f319;f320;f321;f322;f323;f324;...
        f325;f326;f327;f328;f329;f330;...
        f331;f332;f333;f334;f335;f336];

return