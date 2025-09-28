function [V1,V2]=sinefitting(Data)
% [V1,V2]=sinefitting(Data)
%
%   Data:table(timeindex, CH1, CH2) con proprietà custom Tc e Toss
%   Tc: periodo di campionamento
%   Toss: periodo di campionamento
%   V1: [A,f,phi] CH1
%   V2: [A,f,phi] CH2
% 
% Utilizza fft e restituisce ampiezza, frequenza principale e fase dei segnali di CH1 e CH2
% 
% 

Tc=Data.Properties.CustomProperties.Tc;
Toss=Data.Properties.CustomProperties.Toss;

% Numero di punti considerati per evitare Leakage
Np=ceil(Toss/Tc);

L=length(Data{1:Np,1});
Fs=1/Tc;

Y1=fft(Data{1:Np,2});

% Considero spettro singolo
P12 = abs(Y1/L);
P11 = P12(1:round(L/2+1));
P11(2:end-1) = 2*P11(2:end-1);

f = Fs/L*(0:(L/2));
[A1,i]=max(P11);
f1=f(i);
phi1=angle(Y1(i));
V1=[A1,f1,phi1];


Y1=fft(Data{1:Np,3});

P12 = abs(Y1/L);
P11 = P12(1:round(L/2+1));
P11(2:end-1) = 2*P11(2:end-1);


f = Fs/L*(0:(L/2));
% size(f)
% size(P11)
% figure
% plot(f,P11,'*') 
% title("Single-Sided Amplitude Spectrum of X(t)")
% xlabel("f (Hz)")
% ylabel("|A(f)|")
% grid on


[A2,i]=max(P11);
f2=f(i);
phi2=angle(Y1(i));
V2=[A2,f2,phi2];

end