clc;
clear;
close all;
% figure(1)is already generate
hold on;
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
r = 250;
xc = 300;
yc = 0;
t = 0 :.01 : pi;
len1 = length(t);
x = r * cos(t) + xc;
y = r * sin(t) + yc;
plot(x, y,'k','LineWidth',2);
plot(xc, yc,'.r','LineWidth',5);

xc=300;
yc=400;
t = 0 : .01 : pi;
len2 = length(t);
x = r * cos(t) + xc;
y = -r * sin(t) + yc;
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

r=632;
xc=0;
yc=0;
t = 0 : .01 : pi/2;
len3 = length(t);
x = r * cos(t) + xc;
y = r * sin(t) + yc;
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);


figure(2); % figure(2) you should generate sample base on figure(1)
mu = 2;
sigma = 20;
hold on;
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);

% generate you your sample point here
circleplot(530,200,20,pi); % drawing the robot

t = 0 :.01 : pi;
[x1, y1] = sample_generate(300, 0, len1, t, 250);
t = 0 :.01 : pi;
[x2, y2] = neg_sample_generate(300, 400, len2, t, 250);
t = 0 :.01 : pi/2;
[x3, y3] = sample_generate(0, 0, len3, t, 632);

p = [x1 y1; x2 y2; x3 y3];
total_len = len1+len2+len3;
w = zeros(total_len, 1);
sum = 0;
for i = 1:length(p)
    xc = 300;yc = 0;
    d1 = pdist2(p(i,:), [xc yc]);
    xc=300;yc=400;
    d2 = pdist2(p(i,:), [xc yc]);
    xc=0;yc=0;
    d3 = pdist2(p(i,:), [xc yc]);
    w(i) = normpdf(d1, 250, sigma) * normpdf(d2, 250, sigma) * normpdf(d3, 632, sigma);
    sum = sum + w(i);
end
for i = 1:length(w)
    w(i) = w(i) / sum;
end


figure(3);
hold on;
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
% figure(3) implement your resampling algorithm
c = zeros(total_len, 1);
u = total_len^-1:total_len^-1:1;
u = u';
c(1) = w(1);
rp = p;
for i = 2:total_len
    c(i) = c(i-1) + w(i);
end
i = 1;
for j = 1:total_len
    while u(j) > c(i)
        if i + 1 > total_len
            break;
        end
        i = i + 1;
    end
    rp(j,1) = p(i,1);
    rp(j,2) = p(i,2);
end
scatter(rp(:, 1), rp(:, 2),'filled');
circleplot(530,200,20,pi); % drawing the robot


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

function [x_, y_] = sample_generate(xc, yc, len, t_, r_)
mu = 2;
sigma = 20;
x_ = cos(t_)' .* r_ + xc;
y_ = sin(t_)' .* r_ + yc;
x_ = sigma * randn(len, 1) + x_;
y_ = sigma * randn(len, 1) + y_;
scatter(x_, y_,'filled');
plot(xc, yc,'.r','LineWidth',5);
end

function [x_, y_] = neg_sample_generate(xc, yc, len, t_, r_)
mu = 2;
sigma = 20;
x_ = cos(t_)' .* r_ + xc;
y_ = -sin(t_)' .* r_ + yc;
x_ = sigma * randn(len, 1) + x_;
y_ = sigma * randn(len, 1) + y_;
scatter(x_, y_,'filled');
plot(xc, yc,'.r','LineWidth',5);
end