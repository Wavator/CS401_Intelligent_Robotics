clc
close all
clear all
x = zeros(200); y = zeros(200);
x(1) = -0.25; y(1) = -1;
for k = 2:200
    v = 1;
    x(k) = x(k - 1);
    y(k) = v*0.01 + y(k - 1);
end
draw_f()
draw(x,y)

function draw_f()
[x,y] = meshgrid(-1.2: 0.3: 1.2,-1.2: 0.3: 1.2);
u = zeros(size(x,1), size(x,2));
v = ones(size(y,1), size(y,2));
quiver(x, y, u, v)
hold on
end