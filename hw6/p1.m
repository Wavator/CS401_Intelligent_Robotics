function p1()
close all;
clc;
clear;
zt = 1:0.0005:50;
q = beam_range_finder_model(zt, length(zt))   ;
plot(zt, q);
end

function [q] = beam_range_finder_model(zt, K)
    noise = 0.5;
    z_tk_star = ones(1, length(zt)) * mean(zt);
    z_tk = zt;
    sigma_hit=1;
    lambda_short=0.0015;
    z_hit=0.15;
    z_short=0.35;
    z_MAX = 50;
    z_max=0.1;
    z_rand=0.4;

    q = z_hit * p_hit(z_tk, z_tk_star, sigma_hit, z_MAX)...
        + z_short * p_short(z_tk, z_tk_star, lambda_short)...
        + z_max * p_max(z_tk, z_MAX)...
        + z_rand * p_rand(z_tk, z_MAX);
    
    function [p_hit] = p_hit(z_tk,z_tk_star, sigma_hit, z_MAX)
        N = zeros(1, length(z_tk));
        eta = 0;
        for i = 1:length(z_tk)
            if (z_tk(i) >= 0 && z_tk(i) <= z_MAX)
                N(i) = (1 / (2*pi*sigma_hit^2)^0.5)*(exp(-0.5*(z_tk(i)-z_tk_star(i))^2/(sigma_hit^2)));
                eta = eta + N(i) * 0.0005;
            end
        end
        eta = 1 / eta;
        p_hit = eta * N;
    end

    function [p_short] = p_short(z_tk, z_tk_star, lambda_short)
        p_short = zeros(1, length(z_tk));
        for i = 1:length(z_tk)
            if (z_tk(i) >= 0 && z_tk(i) <= z_tk_star(i))
                eta = 1 / (1 - exp(-lambda_short*z_tk_star(i)));
                p_short(i) = eta * lambda_short * exp(-lambda_short * z_tk(i));
            else
                p_short(i) = 0;
            end
        end
    end

    function [p_max] = p_max(z_tk, z_MAX)
        p_max = zeros(1, length(z_tk));
        for i = 1:length(z_tk)
            if (z_tk(i) == z_MAX)
                p_max(i) = 1;
            else
                p_max(i) = 0;
            end
        end
    end

    function [p_rand] = p_rand(z_tk, z_MAX)
        p_rand = zeros(1, length(z_tk));
        for i = 1:length(z_tk)
            if (z_tk(i) >= 0 && z_tk(i) <= z_MAX)
                p_rand(i) = 1 / z_MAX;
            else
                p_rand(i) = 0;
            end
        end
     end
end