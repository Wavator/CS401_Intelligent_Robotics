function draw_absx_distribution()
clc;
clear all;
%% =======================
x_min = -5;
x_max = 5;
y_min = 0;
y_max = 0.02;
axis([x_min x_max y_min y_max]);
hold on;
max_num_sample = 1000000;
xx(1) = 0;
for i=1:max_num_sample
    xx(i) = sample_distribution(absx_distribution, 1);
end
histogram(xx, 'Normalization', 'probability');
end

function [x]=sample_distribution(f,b)
    x = 0;
    y = 0;
    while 1
    x = random_range(-b, b);
    y = random_range(0, 1);
        if(y <= f(x))
            break;
        end
    end
end

function F=absx_distribution()
    function [y]=distribution(x)
        if x <= 1 && x >= -1
            y = abs(x);
        else 
            y = 0;
        end
    end
    F=@distribution;
end

function [y] = random_range(a, b)
    y = a + (b - a) * rand();
end