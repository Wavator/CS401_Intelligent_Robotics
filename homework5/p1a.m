function draw_normal_distribution()
clc;
clear all;
%% =======================
x_min = -5;
x_max = 5;
y_min = 0;
y_max = 0.015;
axis([x_min x_max y_min y_max]);
hold on;
xx(1) = 0;
max_num_sample = 1000000;
for i=1:max_num_sample
    xx(i) = sample_distribution(normal_distribution, 3);
end
histogram(xx, 'Normalization', 'probability');
end

function [x]=sample_distribution(f,b)
    x = 0;
    y = 0;
    while 1
    x = random_range(-b, b);
    y = random_range(0, 1/sqrt(2*pi));
        if(y <= f(x))
            break;
        end
    end
end

function F=normal_distribution()
    function [y]=distribution(x)
        y = 1/sqrt(2*pi)*exp(-x^2/2);
    end
    F=@distribution;
end

function [y] = random_range(a, b)
    y = a + (b - a) * rand();
end
