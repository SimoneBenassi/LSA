clear
clc

Data=readtable('data_16_022.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');

Data.Properties.CustomProperties.Tc=100e-6;
Tc=Data.Properties.CustomProperties.Tc;
Data.Properties.CustomProperties.Toss=1;
tempi=Tc*Data{:,1};

% Segnale nel dominio del tempo
signal22=figure;
plot(tempi,Data{:,2}.*0.125,tempi,Data{:,3}.*0.125);
legend('Input','Output')
xlabel('t [s]');
ylabel('mV');
grid on
Toss=Data.Properties.CustomProperties.Toss;

% Numero di punti considerati 
Np=floor(Toss/Tc);
L=length(Data{1:Np,1});
Fs=1/Tc;

% Considero spettro singolo
Y1=fft(Data{1:Np,3});
P12 = abs(Y1/L);
P11 = P12(1:round(L/2+1));
P11(2:end-1) = 2*P11(2:end-1);

f = Fs/L*(0:(L/2));
figure
subplot(1,2,1)
plot(f,P11,'*') 
title("Spettro con leakage")
xlabel("f (Hz)")
ylabel("|A(f)|")
grid on

% Spettro senza Leakage
Data.Properties.CustomProperties.Toss=0.9881;
Toss=Data.Properties.CustomProperties.Toss;

% Numero di punti considerati per evitare Leakage
Np=floor(Toss/Tc);
L=length(Data{1:Np,1});
Fs=1/Tc;
Y1=fft(Data{1:Np,3});

% Considero spettro singolo
P12 = abs(Y1/L);
P11 = P12(1:floor(L/2+1));
P11(2:end-1) = 2*P11(2:end-1);

f = Fs/L*(0:(L/2));
subplot(1,2,2)
plot(f,P11,'*') 
title("Spettro senza leakage")
xlabel("f (Hz)")
ylabel("|A(f)|")
grid on

% Main contributor: Simone Benassi