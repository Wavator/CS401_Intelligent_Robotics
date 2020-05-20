clc;
clear;
close all;


x = zeros(6, 1);
y = zeros(6, 1);
max_wid = 600;
max_len = 400;
x0 = max_wid/2;
y0 = max_len/2;
x(1) = 0; 
y(1) = 0;
x(2) = 0;
y(2) = max_len;
x(3) = max_wid/2; 
y(3) = 0;
x(4) = max_wid/2; 
y(4) = max_len;
x(5) = max_wid; 
y(5) = 0;
x(6) = max_wid; 
y(6) = max_len;
figure(1);
hold on;
axis([0 max_wid 0 max_len]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
circleplot(max_wid/2,max_len / 2,20,0);
scatter(x, y, 'filled', 'r');
sigma = 10;
rand_times = 10000;
X = max_wid * abs(randn(rand_times, 1));
Y = max_len * abs(randn(rand_times, 1));
angle = atan2(y-y0, x-x0);
dis  = pdist2([x0 y0], [x y]);
theta = 2 * pi * abs(randn(rand_times, 1));
w = zeros(rand_times, 1);
sum = 0;
for i = 1:rand_times
    p_ = atan2(y-Y(i), x-X(i)) - theta(i);
    w(i) = prod(normpdf(p_, angle, sigma));
    p11 = [X(i) Y(i)];
    p22 = [x y];
    range = pdist2(p11, p22);
    w(i) =  w(i) *  prod(normpdf(range, dis, sigma));
    sum = sum + w(i);
end
w = w / sum;

quiver(X, Y, sin(theta), cos(theta), 0.5);

figure(2);
hold on;
axis([0 max_wid 0 max_len]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
circleplot(max_wid/2,max_len/2,20,0);
scatter(x, y, 'filled', 'r');
circleplot(max_wid/2,max_len/2,20,0);

c = zeros(rand_times, 1);
u = rand_times^-1:rand_times^-1:1;
u = u';
for i = 1:rand_times
    if i == 1
        c(i) = c(1);
    else
        c(i) = c(i-1) + w(i);
    end
end
i = 1;
for j = 1:rand_times
    while u(j) > c(i)
        if i + 1 > rand_times
            break;
        end
        i = i + 1;
    end
    rx(j) = X(i);
    ry(j) = Y(i);
    rtheta(j) = theta(i);
end
quiver(rx, ry, sin(rtheta), cos(rtheta), 5);

function circleplot(xc, yc, r, theta)
t = 0 : .01 : 2*pi;
x = r * cos(t) + xc;
y = r * sin(t) + yc;
plot(x, y,'r','LineWidth',2)
t2 = 0 : .01 : r;
x = t2 * cos(theta) + xc;
y = t2 * sin(theta) + yc;
plot(x, y,'r','LineWidth',2)
end