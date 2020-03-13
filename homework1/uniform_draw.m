clc
close all
clear all
x = zeros(200); y = zeros(200);
x(1) = - 1; y(1) = .25;
for k = 2:200
    a = 1;
    x(k) = a * 0.01 + x(k - 1);
    y(k) = y(k - 1);
end
draw_f()
draw(x,y)
hold off
function draw_f()
[x,y] = meshgrid(-1.2: 0.3: 1.2,-1.2: 0.3: 1.2);
quiver(x, y, ones(9), zeros(9));
hold on
end