% 装载数据
clear;
clc;
load('sqtraj1.mat');
% load('data_q6_100.mat');

% 输入ur和dt；
ur = sqtraj1(:,6);
% ur = qc(:,1);
dt = 0.04; 
% dt = 0.01; 
% 获取初始字母表sigmao
[sigmao, str_line] = InitSigmao(ur,dt);

% 设置运行时间
t = (0:dt:dt*(length(ur)-1))';
% 设置允许误差
eps = 0.005;
eps1 = 0.0005;
% 分段输入信号
[ui, s] = Segmentation(ur, dt, eps);
% 对输入信号进行延拓
[us, sigmas, B, Ts] = Scaling(ui, sigmao, s, dt);

[j, mk] = size(sigmas);
[n, mk] = size(us);

% 根据输入是否为直线分两种情况构建和重建
if(str_line == 1)
    %如果是直线就直接输出
    u_re = sigmas;
    % 重构时间变量ts=Ts*bate
    for p=1:n
        for i=1:mk
            tn(i)=B(p)*Ts*(i-1)/(mk-1);
        end
        if p == 1
            ts = tn;
        else
            ts=[ts,tn+ts(mk*(p-1))+dt];
        end
    end
else
    %不是直线则有下面的一堆重构
    % 计算矩阵G,j*j
    for i=1:j
        for p=1:j
            G(i,p) = InnerProducts(sigmas(i,:), sigmas(p,:), dt);
        end
    end

    % 计算向量v
    A = [];
    i=1;

    while (i<n+1)
        for p=1:j
            v(p,1) = InnerProducts(us(i,:), sigmas(p,:), dt); 
        end
        alpha = G\v;
        if (abs(InnerProducts(us(i,:), us(i,:), dt)-alpha'*G*alpha) < eps1)
            A = [A;alpha']; % A的每一行是一个segment对应的参数表示
            i = i+1;
        else
            for p=1:mk
                uiv(p) = us(i,p) - alpha'* sigmas(:,p);
            end
            sigmas = [sigmas;uiv];
            % 重新计算计算矩阵G,j+1*j+1
            j = j+1;
            for i=1:j
                for p=1:j
                    G(i,p) = InnerProducts(sigmas(i,:), sigmas(p,:), dt);
                end
            end
            i = 1;
            clear A;
            A = [];
        end
    end

    % 重构参考输入信号
    [j, mk]=size(sigmas);
    [n, j]=size(A);
    % 重构ur
    u_re = [];

    for p=1:n
        x = zeros(1,mk);
        for i=1:j   
            x = x + sigmas(i,:)*A(p,i);
            % u_re(p,:) = x;
        end
        u_re = [u_re,x];
    end
    %u_re = [q(1),u_re];
    % 重构时间变量ts=Ts*bate
    for p=1:n
        for i=1:mk
            tn(i)=B(p)*Ts*(i-1)/(mk-1);
        end
        if p == 1
            ts = tn;
        else
            ts=[ts,tn+ts(mk*(p-1))+dt];
        end
    end
    %ts = [0,ts];
end


% 显示重构信号
plot(ts,u_re);
hold;
% 显示输入信号
plot(t,ur);







