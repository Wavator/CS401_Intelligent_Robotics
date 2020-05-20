m = [2, 2; 2, 4; 4, 4; 4, 2];
x = [3;3;pi/2];
u = [1;1;pi/2];
Q = 0.1;
A = eye(2, 2);
B = eye(2, 2);
C = [1, 0; -1,0; 0, 1; 0, -1];
D = [-1. 0, 0, 0; 0, 1, 0, 0; 0, 0, -1, 0; 0, 0, 0, 1];
R = 0.03;
 
sigma = ones(2, 2);
zt = zeros(4, 1);
for nt = 1:4
    zt(nt) = sqrt((m(nt,1)-x(1))^2 + (m(nt,2)-x(2))^2);
end
 
hold on;
plot(m(1, :), m(2, :), 'kh', 'MarkerSize', 7);
plot(m(3, :), m(4, :), 'kh', 'MarkerSize', 7);
 
mut = x + u + normrnd(0, Q, 3, 1);
Gt = eye(2);
Qt = diag(ones(2, 1) * Q);
sigma_ = Gt * sigma * Gt' + Qt;
 
zn = numel(m(:,1));
Rt = diag(ones(2, 1) * R);
for n = 1:zn
    M = m(n, :);
    q = (M(1) - mut(1))^2 + (M(2) - mut(2))^2;
    zt_ = sqrt(q);
 
    Ht = [-(M(1)-mut(1))/sqrt(q), -(M(2)-mut(2))/sqrt(q); (M(2)-mut(2))/q, -(M(1)-mut(1))/q];
    St = Ht * sigma_*(Ht)' + Rt;
    Kt = sigma_*(Ht)' * inv(St);
    diff = zt(n)' - zt_;
    if diff <= 0.1
        mut = mut + Kt * diff;
        sigma_ = (eye(2) - Kt * Ht) * sigma_;
    end
end
 
figure(1);
set(gcf, 'outerposition', get(0, 'screensize'));
plot(x(1), x(2), '-g', 'linewidth', 2); hold on;
plot(mut(1), mut(2), 'xr', 'linewidth', 2); hold on;
axis equal;
ShowErrorEllipse([mut(1), mut(2)], sigma_, 1);
drawnow;