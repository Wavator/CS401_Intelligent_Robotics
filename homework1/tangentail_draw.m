clc;
clear all£»
close all;
x = zeros(200);
y = zeros(200);
x(1) = 0.25;
y(1)=-0.25;
for k = 2:200
    v = sqrt((x(k-1))^2+(y(k-1)).^2)*2;
    u = v * (2 * y(k - 1) / v);
    if (x(k - 1) <= 0)
        v = v * (sqrt(1 - ((2 * y(k - 1) / v) ^ 2)));
    else
        v = - v * (sqrt(1 - ((2 * y(k - 1) / v) ^ 2)));
    end
    x(k) = u*0.01 + x(k - 1);
    y(k) = v*0.01 + y(k - 1);
end
draw_f()
draw(x,y)
function draw_f()
[x,y] = meshgrid(-1.2: 0.3: 1.2,-1.2: 0.3: 1.2);
v_ = sqrt((x).^2 + (y).^2)*2;
u = v_.*(2.*y./v_);
v = v_.*(sqrt(1-((2.*y./v_).^2))).*(x<=0) - ...
v_.*(sqrt(1-((2.*y./v_).^2))).*(x> 0) ;
quiver(x, y, u, v);
hold on
end