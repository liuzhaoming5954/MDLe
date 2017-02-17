function epsilon=ProjectingAndTesting(us, sigmas, dt, G)
% INPUT
% us: n*max(m,k)����
% sigmas: j*max(m,k)����
% dt: ����ʱ����
% OUTPUT
% epsilon: 1*n����������ʾÿһ��segment�ֽ⵽��ĸ���Ժ�����ֵ

% ������󳤶�
[n, mk]=size(us);
[j, mk]=size(sigmas);

% ��������v
for i=1:n
    for p=1:j
        v(p,i) = InnerProducts(us(i,:), sigmas(p,:), dt); % v��һ��j*n�ľ���
    end
end

% �������G,j*j
% for i=1:j
%     for p=1:j
%         G(i,p) = InnerProducts(sigmas(i,:), sigmas(p,:), dt);
%     end
% end

% ����alpha��j*n
alpha = inv(G)*v;

% ����epsilon,1*n������
for i=1:n
    epsilon(i) = abs(InnerProducts(us(i,:), us(i,:), ds)-alpha(:,i)'*G*alpha(:,i));
end