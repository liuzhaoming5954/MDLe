function [a0,a1,a2,a3,a4,a5] = polynomial_5(q0,q1,v0,v1,alpha0,alpha1,t0,t1)

% caculate h and T
h = q1 - q0;
T = t1 - t0;

% caculate parameters of trajectory
a0 = q0;
a1 = v0;
a2 = 0.5*alpha0;
a3 = (1/(2*T^3))*(20*h-(8*v1+12*v0)*T-(3*alpha0-alpha1)*T^2);
a4 = (1/(2*T^4))*(-30*h+(14*v1+16*v0)*T+(3*alpha0-2*alpha1)*T^2);
a5 = (1/(2*T^5))*(12*h-6*(v1+v0)*T+(alpha1-alpha0)*T^2);
