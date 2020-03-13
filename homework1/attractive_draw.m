clc
close all
clear all;
x = zeros(200);
y = zeros(200);
x(1) = 0.6;
y(1) = x(1);
for k = 2:200
    if (x(k - 1) ^ 2 + y(k - 1) ^ 2 >= 1)
        u = 0;
        v = 0;
    else
        u = -x(k-1);
        v = -y(k-1);
    end
    x(k)=u*0.01 + x(k-1);
    y(k)=v*0.01 + y(k-1);
end
draw_f()
draw(x,y)
function draw_f()
aplha=0:pi/40:2*pi;
r=0.01;
n=r*cos(aplha);
m=r*sin(aplha);
fill(n,m,'b');
hold on
a = [-sqrt(2), -sqrt(2), sqrt(2), sqrt(2), 2, -2, 0, 0, -sqrt(2)/2, -sqrt(2)/2, sqrt(2)/2, sqrt(2)/2, 1, -1, 0, 0];
b = [-sqrt(2), sqrt(2), -sqrt(2), sqrt(2), 0, 0, -2, 2, -sqrt(2)/2, sqrt(2)/2, -sqrt(2)/2, sqrt(2)/2, 0, 0, -1, 1];
u = [sqrt(2), sqrt(2), -sqrt(2), -sqrt(2), -2, 2, 0, 0, sqrt(2)/2, sqrt(2)/2, -sqrt(2)/2, -sqrt(2)/2, -1, 1, 0, 0];
v = [sqrt(2), -sqrt(2), sqrt(2), -sqrt(2), 0, 0, 2, -2, sqrt(2)/2, -sqrt(2)/2, sqrt(2)/2, -sqrt(2)/2, 0, 0, 1, -1];
quiver(a, b, u, v);
end