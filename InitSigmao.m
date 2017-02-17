function sigmao = InitSigmao(ur, dt)
% INPUT 
% 参考输入ur
% 采样时间间隔dt同参考输入ur
% OUTPUT
% 输出初始化的sigmao矩阵

% 初始化相关参数
L = length(ur);
ti = 0;
tf = ti+dt*(L-1);
% v0 = 0;
% v1 = 0;
q0 = ur(1);
q1 = ur(L);
%h = q1-q0;
T = tf-ti;

% 产生采样时间
t1 = [0:dt:tf]';

% 计算基函数参数
[a_l0, a_l1] = linefuntion(q0,q1,ti,tf);
% [a_pa0, a_pa1, a_pa2] = parabola(q0,q1,v0,ti,tf);

a_pa = polyfit(ur,t1,2);
% [a_c0, a_c1, a_c2, a_c3] = cubic(q0,q1,v0,v1,ti,tf);
a_c = polyfit(ur,t1,3);
% [a_p0, a_p1, a_p2, a_p3, a_p4, a_p5] = polynomial_5(q0,q1,v0,v1,0,0,ti,tf);
a_p = polyfit(ur,t1,5);

% Line trajectory function 直线
sigmao(1,:) = a_l0+a_l1*t1;
% sigmao(1,:) = 1+t1;

% Parabola 二次曲线
% sigmao(2,:) = a_pa0+a_pa1*t1+a_pa2*t1.^2;
sigmao(2,:) = a_pa(1)+a_pa(2)*t1+a_pa(3)*t1.^2;
% sigmao(2,:) = 1+t1+t1.^2;

% Cubic trajectory function 三次曲线
% sigmao(3,:) = a_c0+a_c1*t1+a_c2*t1.^2+a_c3*t1.^3;
sigmao(3,:) = a_c(1)+a_c(2)*t1+a_c(3)*t1.^2+a_c(4)*t1.^3;
% sigmao(3,:) = 1+t1+t1.^2+t1.^3;

% Polynomial_5 trajectory function 五次曲线
% sigmao(4,:) = a_p0+a_p1*t1+a_p2*t1.^2+a_p3*t1.^3+a_p4*t1.^4+a_p5*t1.^5;
sigmao(4,:) = a_p(1)+a_p(2)*t1+a_p(3)*t1.^2+a_p(4)*t1.^3+a_p(4)*t1.^4+a_p(5)*t1.^5;
% sigmao(4,:) = 1+t1+t1.^2+t1.^3+t1.^4+t1.^5;

% Sin function
% sigmao(5,:) = sin(t1);

% Harmonic trajectory function
% sigmao(6,:) = 1/2*(1-cos((t1*pi)/T))+1;

% Cycloidal trajectory funtion
% sigmao(4,:) = (q1-q0)*(t1/T-1/2*pi*sin(2*pi*t1/T))+q0;