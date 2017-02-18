function [sigmao, str_line] = InitSigmao(ur, dt)
% INPUT 
% 参考输入信号：ur
% 采样时间间隔：dt同参考输入ur
% OUTPUT
% 输出初始化的sigmao矩阵
% 直线标志：str_line 1表示参考信号为直线，0表示参考信号不是直线

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
i = 1; % 确定Sigmao的个数
% 计算基函数参数

% 生成直线基函数
[a_l0, a_l1] = linefuntion(q0,q1,ti,tf);
% Line trajectory function 直线
sigmao(i,:) = a_l0+a_l1*t1;
% Calculate Frechet-distance between two function
if(frechet(t1,ur,t1,sigmao(i,:)')<=0.0001)
    str_line = 1; %直线标志位，是一条直线
    fprintf('%s\n','轨迹是一条直线');
else
    i = i+1;
    
    a_pa = polyfit(ur,t1,2);
    % Parabola 二次曲线
    sigmao(i,:) = a_pa(1)+a_pa(2)*t1+a_pa(3)*t1.^2;
    i = i+1;
    
    a_c = polyfit(ur,t1,3);
    % Cubic trajectory function 三次曲线
    sigmao(i,:) = a_c(1)+a_c(2)*t1+a_c(3)*t1.^2+a_c(4)*t1.^3;
    i = i+1;
    
    a_p = polyfit(ur,t1,5);
    % Polynomial_5 trajectory function 五次曲线
    sigmao(i,:) = a_p(1)+a_p(2)*t1+a_p(3)*t1.^2+a_p(4)*t1.^3+a_p(4)*t1.^4+a_p(5)*t1.^5;
    
    str_line = 0;% 直线标志位，不是直线
end

% [a_pa0, a_pa1, a_pa2] = parabola(q0,q1,v0,ti,tf);


% 生成抛物线基函数
% try
%     a_pa = polyfit(ur,t1,2);
%     % Parabola 二次曲线
%     sigmao(i,:) = a_pa(1)+a_pa(2)*t1+a_pa(3)*t1.^2;
%     i = i+1;
% catch
%     fprintf('%s\n','没能生成抛物线');
% end
% 
% % [a_c0, a_c1, a_c2, a_c3] = cubic(q0,q1,v0,v1,ti,tf);
% 
% % 生成三次曲线基函数
% try
%     a_c = polyfit(ur,t1,3);
%     % Cubic trajectory function 三次曲线
%     sigmao(i,:) = a_c(1)+a_c(2)*t1+a_c(3)*t1.^2+a_c(4)*t1.^3;
%     i = i+1;
% catch
%     fprintf('%s\n','没能生成三次曲线');
% end
% 
% % [a_p0, a_p1, a_p2, a_p3, a_p4, a_p5] = polynomial_5(q0,q1,v0,v1,0,0,ti,tf);
% 
% % 生成五次曲线基函数
% try
%     a_p = polyfit(ur,t1,5);
%     % Polynomial_5 trajectory function 五次曲线
%     sigmao(i,:) = a_p(1)+a_p(2)*t1+a_p(3)*t1.^2+a_p(4)*t1.^3+a_p(4)*t1.^4+a_p(5)*t1.^5;
% catch
%     fprintf('%s\n','没能生成五次抛物线');
% end

% Line trajectory function 直线
%sigmao(1,:) = a_l0+a_l1*t1;
% sigmao(1,:) = 1+t1;

% Parabola 二次曲线
% sigmao(2,:) = a_pa0+a_pa1*t1+a_pa2*t1.^2;
%sigmao(2,:) = a_pa(1)+a_pa(2)*t1+a_pa(3)*t1.^2;
% sigmao(2,:) = 1+t1+t1.^2;

% Cubic trajectory function 三次曲线
% sigmao(3,:) = a_c0+a_c1*t1+a_c2*t1.^2+a_c3*t1.^3;
%sigmao(3,:) = a_c(1)+a_c(2)*t1+a_c(3)*t1.^2+a_c(4)*t1.^3;
% sigmao(3,:) = 1+t1+t1.^2+t1.^3;

% Polynomial_5 trajectory function 五次曲线
% sigmao(4,:) = a_p0+a_p1*t1+a_p2*t1.^2+a_p3*t1.^3+a_p4*t1.^4+a_p5*t1.^5;
%sigmao(4,:) = a_p(1)+a_p(2)*t1+a_p(3)*t1.^2+a_p(4)*t1.^3+a_p(4)*t1.^4+a_p(5)*t1.^5;
% sigmao(4,:) = 1+t1+t1.^2+t1.^3+t1.^4+t1.^5;

% Sin function
% sigmao(5,:) = sin(t1);

% Harmonic trajectory function
% sigmao(6,:) = 1/2*(1-cos((t1*pi)/T))+1;

% Cycloidal trajectory funtion
% sigmao(4,:) = (q1-q0)*(t1/T-1/2*pi*sin(2*pi*t1/T))+q0;