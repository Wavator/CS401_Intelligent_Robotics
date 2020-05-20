clc;
clear all;
close all;
dT=0.5;
u=[3,3];
origin=[0,0,0];
xx(1) = 0;
yy(1) = 0;
a = [0.021, 0.021, 0.01, 0.01, 0.002, 0.002];
for i = 1:500
[xx(i), yy(i)] = sample_motion_model_velocity(u,origin,a,dT);
end
scatter(0,0,'filled');
hold on;
scatter(xx, yy, 'filled', 'r');
hold on;

function [x1,y1] = sample_motion_model_velocity(u,x,a,dT)
v0=u(1);
w0=u(2);
v=v0+sample(a(1)*v0^2+a(2)*w0^2);
w=w0+sample(a(3)*v0^2+a(4)*w0^2);
r=sample(a(5)*v0^2+a(6)*w0^2);
x0=x(1);
y0=x(2);
t0=x(3);
x1=x0+v/w * (sin(t0+w*dT) - sin(t0));
y1=y0+v/w * (cos(t0) - cos(t0+w*dT));
t1=t0+w*dT+r*dT;
end

function x = sample(b)
x = 0;
for i = 1:12
x = x + random_range(-b, b);
end
x = x / 2;
end

function [y] = random_range(a, b)
    y = a + (b - a) * rand();
end