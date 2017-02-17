% װ������
clear;
clc;
load('sqtraj1.mat');
% load('data_q6_100.mat');
% ���ȸ���һ��sigmao
% sigmao = [1,1,1,1,1;2,1,1,2,1];

% ����ur��dt��
ur = sqtraj1(:,3);
% ur = qc(:,1);
dt = 0.04; 
% dt = 0.01; 
% ��ȡ��ʼ��ĸ��sigmao
[sigmao, str_line] = InitSigmao(ur,dt);

% TODO
if(str_line = 1)
    %�����ֱ�߾�ֱ�����
else
    %����ֱ�����������һ���ع�
end


t = (0:dt:dt*(length(ur)-1))';
eps = 0.005;
eps1 = 0.0005;

[ui, s] = Segmentation(ur, dt, eps);
[us, sigmas, B, Ts] = Scaling(ui, sigmao, s, dt);

[j, mk] = size(sigmas);
[n, mk] = size(us);
% �������G,j*j
for i=1:j
    for p=1:j
        G(i,p) = InnerProducts(sigmas(i,:), sigmas(p,:), dt);
    end
end

% ��������v
A = [];
i=1;

while (i<n+1)
    for p=1:j
        v(p,1) = InnerProducts(us(i,:), sigmas(p,:), dt); 
    end
    alpha = G\v;
    if (abs(InnerProducts(us(i,:), us(i,:), dt)-alpha'*G*alpha) < eps1)
        A = [A;alpha']; % A��ÿһ����һ��segment��Ӧ�Ĳ�����ʾ
        i = i+1;
    else
        for p=1:mk
            uiv(p) = us(i,p) - alpha'* sigmas(:,p);
        end
        sigmas = [sigmas;uiv];
        % ���¼���������G,j+1*j+1
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

% �ع��ο������ź�
[j, mk]=size(sigmas);
[n, j]=size(A);
% �ع�ur
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
% �ع�ʱ�����ts=Ts*bate
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

plot(ts,u_re);
hold;
plot(t,ur);







