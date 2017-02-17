function [a0,a1,a2] = parabola(q0,q1,v0,ti,tf)

h = q1 - q0;
T = tf - ti;

a0 = q0;
a1 = v0;
a2 = 1/T^2*(h-v0*T);