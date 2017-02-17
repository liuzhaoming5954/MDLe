function epsilon=ProjectingAndTesting(us, sigmas, dt, G)
% INPUT
% us: n*max(m,k)矩阵
% sigmas: j*max(m,k)矩阵
% dt: 采样时间间隔
% OUTPUT
% epsilon: 1*n行向量，表示每一个segment分解到字母表以后的误差值

% 求出矩阵长度
[n, mk]=size(us);
[j, mk]=size(sigmas);

% 计算向量v
for i=1:n
    for p=1:j
        v(p,i) = InnerProducts(us(i,:), sigmas(p,:), dt); % v是一个j*n的矩阵
    end
end

% 计算矩阵G,j*j
% for i=1:j
%     for p=1:j
%         G(i,p) = InnerProducts(sigmas(i,:), sigmas(p,:), dt);
%     end
% end

% 计算alpha，j*n
alpha = inv(G)*v;

% 计算epsilon,1*n的向量
for i=1:n
    epsilon(i) = abs(InnerProducts(us(i,:), us(i,:), ds)-alpha(:,i)'*G*alpha(:,i));
end