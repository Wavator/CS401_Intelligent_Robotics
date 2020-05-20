function draw_triangular_distribution()
clc;
clear all;
%% =======================
x_min = -3;
x_max = 3;
y_min = 0;
y_max = 0.015;
axis([x_min x_max y_min y_max]);
hold on;
max_num_sample = 1000000;
xx(1) = 0;
for i=1:max_num_sample
    xx(i) = sample_distribution(triangular_distribution, 3);
end
histogram(xx, 'Normalization', 'probability');
end

function [x]=sample_distribution(f,b)
    x = 0;
    y = 0;
    while 1
    x = random_range(-b, b);
    y = random_range(0, 1/sqrt(6));
        if(y <= f(x))
            break;
        end
    end
end

function F=triangular_distribution()
    function [y]=distribution(x)
        y = (sqrt(6) - abs(x)) / 6;
        if abs(x) > sqrt(6)
            y = 0;
        end
    end
    F=@distribution;
end

function [y] = random_range(a, b)
    y = a + (b - a) * rand();
end
