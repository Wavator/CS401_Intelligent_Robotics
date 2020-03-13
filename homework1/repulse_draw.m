clc;
clear all£»
close all;
x = zeros(200); y = zeros(200);
x(1) = -0.25; y(1) = -0.25;
for k = 2:200
    if (x(k - 1) ^ 2 + y(k - 1) ^ 2 >= 2)
        u = 0;
        v = 0;
    else
        u = x(k - 1);
        v = y(k - 1);
    end
    x(k) = u*0.01 + x(k - 1);
    y(k) = v*0.01 + y(k - 1);
end
draw_f()
draw(x,y)
function draw_f()
[x, y] = meshgrid(-1:0.3:1, -1:0.3:1);
quiver(x, y, x, y)
hold on
end