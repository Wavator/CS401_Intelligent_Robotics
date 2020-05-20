function p3()
close all
clear
a = [0 0];
b = [0 1];
c = [1 2];
d = [2 1];

%% 
%% row 20 column 2
%%

pd = zeros(20, 2);

dis_a = pdist2(a, d);
dis_b = pdist2(b, d);
dis_c = pdist2(c, d);

function dr = cal(p)
    pa = pdist2(a, p);
    pb = pdist2(b, p);
    pc = pdist2(c, p);
    
    dr(1) = abs(pa - nda);
    dr(2) = abs(pb - ndb);
    dr(3) = abs(pc - ndc);
end

options = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt');
for i = 1:20
    nda = dis_a + 0.1*rand();
    ndb = dis_b + 0.1*rand();
    ndc = dis_c + 0.1*rand();
    pd(i, :) = fsolve(@cal, [0 0], options);
end

sample_theta=0:2*pi/3600:2*pi;
r = 0.01;
factor = 2;
c1= a(1) + factor*r*cos(sample_theta);
c2= a(2) + factor*r*sin(sample_theta);
plot(c1,c2,'m','Linewidth',2);
hold on
c1= b(1) + factor*r*cos(sample_theta);
c2= b(2) + factor*r*sin(sample_theta);
plot(c1,c2,'m','Linewidth',2);
hold on
c1= c(1) + factor*r*cos(sample_theta);
c2= c(2) + factor*r*sin(sample_theta);
plot(c1,c2,'m','Linewidth',2);
hold on
for i=1:length(pd)
    c1= pd(i, 1) + r*cos(sample_theta);
    c2= pd(i, 2) + r*sin(sample_theta);
    plot(c1,c2,'b','Linewidth',3);
    hold on
end

end