function [phi_uni] = uniform_phi(phi)
% [phi_uni] = uniform_phi(phi)
% Uniforma la fase tra -180°  e+180°
N=length(phi);
phi_uni=zeros(N,1);
for i=1:N
if phi(i)>pi
    phi_uni(i)=phi(i)-2*pi;
else   
if phi(i)<-pi
    phi_uni(i)=phi(i)+2*pi;  
else
    phi_uni(i)=phi(i);
end
end
end