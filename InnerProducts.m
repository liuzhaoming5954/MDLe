function V=InnerProducts(u, v, dt)
% 求内积函数

mk=length(u);

V = 0;
for s=1:mk-1
    V = V+dt/2*(u(s+1)*v(s+1)+u(s)*v(s));
end
