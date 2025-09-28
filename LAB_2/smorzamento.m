clear
clc
close all

Data=readtable("data_16_042.csv");
Tc=2e-4;
figure;
plot(Data{:,1}*Tc,Data{:,3}*0.25)
xlabel('t [s]');
ylabel('Output [mV]');
title('Risposta impulso')
grid on
% Rimuoviamo la parte di segnale prima dell'impulso
signal=Data{1192:5000,3};
timesteps=(Data{1192:5000,1}-1)*Tc;


N=0.5*length(signal)
Index_max=[]
% prendo i massimi (calcolati in intorni di 5 punti)
for i=2:N
     if signal(i)>=0
        if(signal(i)>signal(i-1)&& signal(i)>signal(i+1)&&signal(i)>signal(i-2)&&signal(i)>signal(i+2))
        Index_max=[Index_max i];
        end
     end
end
massimi=figure
plot(timesteps(Index_max),signal(Index_max)*0.25,'LineWidth',1.5)
grid on
xlabel('t [s]');
ylabel('Output [mV]');
title('Primo tentativo: massimi');

% Devo selezionare ancora il max tra quelli che ho ottenuto (segnale
% rumoroso)
Index_max2=[];
j=1;
for i=Index_max(2:end-2)
    j=j+1;
if(signal(i)>signal(Index_max(j-1))&& signal(i)>signal(Index_max(j+1)))
        Index_max2=[Index_max2 i];
end

end
% fitting a*exp(b*x)
espo = fit(timesteps(Index_max2),signal(Index_max2),'exp1');
% ho anche i valori dell'intervallo di confidenza

espofig=figure;
plot(timesteps(Index_max2),signal(Index_max2).*0.25,'x',timesteps,0.25.*espo.a*exp(espo.b*timesteps),'LineWidth',1.5)
xlabel('t [s]');
ylabel('Output [mV]');
legend('Creste','a*exp($-\xi*\omega _n$)','Interpreter','latex')

grid on

% Uso fourier per la frequenza fn

% Taglio il segnale nella parte significativa e moltiplico per exp(wn*xi)
% per rendere uniforme
modsignal=signal(100:759,1).*(1/espo.a).*exp(-espo.b*timesteps(100:759,1));
uniforme=figure;
plot(timesteps(100:759,1), modsignal,'LineWidth',1.5);
xlabel('t [s]');
ylabel('Output');
grid on
legend('cos($\omega t$)','Interpreter','latex')


Fs=1/Tc;
L=length(modsignal)
Y=fft(modsignal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs/L*(0:(L/2));
smorzfft=figure;
plot(f,P1,"Marker","*") 
title("Spettro delle ampiezze X(t)")
xlabel("f (Hz)")
ylabel("|A(f)|")


[~,i]=max(P1);
f_smorz=f(i);
% trovo pulsazione naturale da f sistema smorzato
wn=sqrt((2*pi*f_smorz)^2+espo.b^2);
fn=wn/(2*pi)
xi=-espo.b/wn
% Main contributor: Simone Benassi