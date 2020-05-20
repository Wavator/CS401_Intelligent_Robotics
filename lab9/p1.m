clear global;
close all;
clc;
disp('kf start');
m = [2,2;2,4;4,4;4,2];
x=[3:3];
u=[1:1];
Q=0.1;
A=eye(2,2);
B=eye(2,2);
C=[1,0;-1,0;0,1;0,-1];
D=[-1,0,0,0;0,1,0,0;0,0,-1,0;0,0,0,1];
R=0.03;
p=ones(2,2);
hold on;
plot(m(1,:),m(2,:),'kh','MarkerSize',7);
plot(m(3,:),m(4,:),'kh','MarkerSize',7);
m_ = [m(1,1);m(3,1);m(1,2);m(3,2)];
mut=A*x+B*u+normrnd(0,Q,2,1);
z=C*x+D*m_+normrnd(0,R,4,1);
p_=A*p*A'+diag(ones(2,1)*Q);
K=p_*C'*(C*p_*C'+diag(ones(4,1)*R))^-1;
x_new=mut+K*(z-C*mut-D*m_);
p_new=p_-K*C*p_;
figure(1);
set(gcf,'outerposition',get(0,'screensize'));
plot(mut(1), mut(2), '-g', 'linewidth',2);
hold on;
plot(x_new(1),x_new(2),'xr','linewidth',2);
hold on;
axis equal;
ShowErrorEllipse([x_new(1),x_new(2)],p_new,1);
drawnow;
function ShowErrorEllipse(estimator, sigma, scale)

covXy = sigma(1:2,1:2); % 
[eigvec, eigval]=eig(covXy); % 

if eigval(1,1)>=eigval(2,2)
    bigind=1;
    smallind=2;
else
    bigind=2;
    smallind=1;
end

chi=9.21; 

t = 0:10:360;
a = sqrt(eigval(bigind,bigind)*chi);
b = sqrt(eigval(smallind,smallind)*chi);
x = [a*cosd(t);
   b*sind(t)];

angle = atan2(eigvec(bigind,2),eigvec(bigind,1));
if(angle < 0)
    angle = angle + 2*pi;
end

R=[cos(angle) sin(angle);
   -sin(angle) cos(angle)];
x = scale * R * x;
plot(x(1,:) + estimator(1), x(2,:) + estimator(2), '-black')
end