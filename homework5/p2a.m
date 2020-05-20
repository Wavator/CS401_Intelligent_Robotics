clc
close all

%Initial setting of mobile robot
x = 0;
y = 0;
theta = pi / 4;
% medium trans
a1 = 0.002;
a2 = 0.002;
a3 = 0.006;
a4 = 0.006;
trajectory_data = zeros(3, 500, 2);
trajectory_data(1, :, 1) = x;
trajectory_data(2, :, 1) = y;
trajectory_data(3, :, 1) = theta;    
delta_rot1 = 0;
delta_trans = 5;
delta_rot2 = 0;    
t = 2;
    % sampling
    for n = 1:500
        delta_rot1_noise = delta_rot1 - normrnd(0, (a1 * delta_rot1^2 + a2 * delta_trans^2));
        delta_trans_noise = delta_trans - normrnd(0, (a3 * delta_trans^2 + a4 * delta_rot1^2 + a4 * delta_rot2^2));
        delta_rot2_noise = delta_rot2 - normrnd(0, (a1 * delta_rot2^2 + a2 * delta_trans^2));

        x = trajectory_data(1,n,t-1) + delta_trans_noise * cos(theta + delta_rot1_noise);
        y = trajectory_data(2,n,t-1) + delta_trans_noise * sin(theta + delta_rot1_noise);
        theta = trajectory_data(3,n,t-1) + delta_rot1_noise + delta_rot2_noise;

        trajectory_data(1,n,t) = x;
        trajectory_data(2,n,t) = y;
        trajectory_data(3,n,t) = theta;
    end
    for m = 1:2
        scatter(trajectory_data(1,5:500,m),trajectory_data(2,5:500,m),'.');
        pause(1);
        hold on
    end