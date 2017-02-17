function [a0,a1,a2,a3] = cubic(q0,q1,v0,v1,t0,t1)

% caculate h and T
h = q1 - q0;
T = t1 - t0;

% caculate parameters of trajectory
a0 = q0;
a1 = v0;
a2 = (3*h-(2*v0+v1)*T)/T^2;
a3 = (-2*h+(v0+v1)*T)/T^3;
