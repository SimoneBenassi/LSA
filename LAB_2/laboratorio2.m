clear
clc
close all

in=zeros(22,3);
out=zeros(22,3);

% Acquisizione dati

Data=readtable('data_16_020.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=100e-6;
Data.Properties.CustomProperties.Toss=0.9149;

[in(1,:),out(1,:)]=sinefitting(Data);


tbl=readtable('data_16_041.csv');

dat=tbl{:,1};
ch1 = tbl{:,2};  % Colonna 2
ch2 = tbl{:,3};  % Colonna 3
ch1= strrep(ch1, ',', '.'); 
ch1 = str2double(ch1); 
ch2= strrep(ch2, ',', '.'); 
ch2 = str2double(ch2); 
Data=table(dat,ch1,ch2);
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');

Data.Properties.CustomProperties.Tc=100e-6;
Data.Properties.CustomProperties.Toss=0.6330;

[in(2,:),out(2,:)]=sinefitting(Data);


tbl=readtable('data_16_039.csv');

dat=tbl{:,1};
ch1 = tbl{:,2};  % Colonna 2
ch2 = tbl{:,3};  % Colonna 3
ch1= strrep(ch1, ',', '.'); 
ch1 = str2double(ch1); 
ch2= strrep(ch2, ',', '.'); 
ch2 = str2double(ch2); 
Data=table(dat,ch1,ch2);
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=100e-6;
Data.Properties.CustomProperties.Toss=0.8652;

[in(3,:),out(3,:)]=sinefitting(Data);


Data=readtable('data_16_021.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=100e-6;
Data.Properties.CustomProperties.Toss=0.9679;

[in(4,:),out(4,:)]=sinefitting(Data);

Data=readtable('data_16_024.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=40e-6;
Data.Properties.CustomProperties.Toss=0.3889;

[in(5,:),out(5,:)]=sinefitting(Data);


Data=readtable('data_16_023.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=40e-6;
Data.Properties.CustomProperties.Toss=0.3807;

[in(6,:),out(6,:)]=sinefitting(Data);


Data=readtable("data_16_027.csv");
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=20*1e-6;
Data.Properties.CustomProperties.Toss=0.09494;

[in(7,:),out(7,:)]=sinefitting(Data);


Data=readtable("data_16_026.csv");
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=40*1e-6;
Data.Properties.CustomProperties.Toss=0.10443;%*3

[in(8,:),out(8,:)]=sinefitting(Data);


Data=readtable('data_16_022.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=100e-6;
Data.Properties.CustomProperties.Toss=0.9881;

[in(9,:),out(9,:)]=sinefitting(Data);


Data=readtable("data_16_028.csv");
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=20e-6;
Data.Properties.CustomProperties.Toss=0.18879;

[in(10,:),out(10,:)]=sinefitting(Data);

Data=readtable('data_16_040.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=20e-6;
Data.Properties.CustomProperties.Toss=0.19306;

[in(11,:),out(11,:)]=sinefitting(Data);


Data=readtable('data_16_029.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=10e-6;
Data.Properties.CustomProperties.Toss=0.06666;

[in(12,:),out(12,:)]=sinefitting(Data);


Data=readtable("data_16_025.csv");
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=20*1e-6;
Data.Properties.CustomProperties.Toss=0.15969;

[in(13,:),out(13,:)]=sinefitting(Data);


Data=readtable('data_16_030.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =20e-6 ;
Data.Properties.CustomProperties.Toss =4*0.0434 ;

[in(14,:), out(14,:)] = sinefitting(Data);


Data=readtable('data_16_031.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =10e-6 ;
Data.Properties.CustomProperties.Toss =2*0.0459;

[in(15,:), out(15,:)] = sinefitting(Data);


Data=readtable('data_16_032.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =10e-6 ;
Data.Properties.CustomProperties.Toss =2*0.0409;

[in(16,:), out(16,:)] = sinefitting(Data);


Data=readtable('data_16_034.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =10e-6 ;
Data.Properties.CustomProperties.Toss =0.0974;

[in(17,:), out(17,:)] = sinefitting(Data);


Data=readtable('data_16_033.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =10e-6 ;
Data.Properties.CustomProperties.Toss =0.0917;

[in(18,:), out(18,:)] = sinefitting(Data);


Data=readtable('data_16_035.csv');
Data = addprop(Data, 'Tc', 'table');
Data = addprop(Data, 'Toss', 'table');
Data.Properties.CustomProperties.Tc =10e-6 ;
Data.Properties.CustomProperties.Toss=0.07916;

[in(19,:), out(19,:)] = sinefitting(Data);


Data=readtable('data_16_036.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=10e-6;
Data.Properties.CustomProperties.Toss=0.09334;

[in(20,:),out(20,:)]=sinefitting(Data);


Data=readtable('data_16_038.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=10e-6;
Data.Properties.CustomProperties.Toss=0.09334;

[in(21,:),out(21,:)]=sinefitting(Data);


Data=readtable('data_16_037.csv');
Data=addprop(Data,'Tc','table');
Data=addprop(Data,'Toss','table');
Data.Properties.CustomProperties.Tc=10e-6;
Data.Properties.CustomProperties.Toss=0.09487;

[in(22,:),out(22,:)]=sinefitting(Data);


if(in(:,2)~=out(:,2))
    error('OUTPUT ha frequenza diversa da INPUT!')
end


%% Diagrammi di bode
Bodesp.A=out(:,1)./in(:,1);
Bodesp.f=in(:,2);
Bodesp.phi=uniform_phi( out(:,3)-in(:,3));

db = @(x) 20 * log10(x);

% Diagramma solo sperimentale
figbodesp=figure;
subplot(2,1,1)
semilogx(Bodesp.f,db(Bodesp.A),'*','Linewidth',2);
xlabel('f [Hz]')
ylabel('$|\frac{out}{in}|_{dB}$','Interpreter','latex'); 
hold on
semilogx(Bodesp.f,db(Bodesp.A),'Linewidth',2);
legend('Segnali campionati','Interpolante lineare','location','southwest');
grid on
hold off

subplot(2,1,2)
semilogx(Bodesp.f,Bodesp.phi.*(180/pi),'*','Linewidth',2);
hold on
xlabel('f [Hz]')
ylabel('\Delta\phi [°]','Interpreter','tex'); 
semilogx(Bodesp.f,Bodesp.phi.*(180/pi),'Linewidth',2);
ylim([-180 180])
legend('Segnali campionati','Interpolante lineare','Location','Northwest');
grid on

% Confronto con modello a 1 gdl
% Dati provino

L=162.5e-3; %[m]
d=35.79e-3; %[m]
t=3.04e-3; %[m]

rho=2700; %[kg/m^3]
xi=0.0515; % Trovato sperimentalmente

E=70e9; %[Pa]
J=d*(t^3)/12; %[m^4]

M=rho*t*d*L;
m=M/2;
k=3*E*J/L^3;
c=xi*2*sqrt(k*m);

% stati [x; x_dot]
A=[0 1;
  -k/m -c/m];
B=[0; 1/m];
C=[k 0]; % fattore moltiplicativo per rendere confrontabili
D=0;
space=ss(A,B,C,D);
G=tf(space);
f_range = logspace(1, 2.5, 1000); % frequency range for Bode plot
[mag_th, phase_th] = bode(G, f_range*2*pi);


% Converto il vettore 3D in una dimensione
mag_th = squeeze(mag_th);
phase_th = squeeze(phase_th);

figure;
subplot(2,1,1)
semilogx(Bodesp.f, db(Bodesp.A), 'DisplayName', 'Sperimentale', 'LineWidth', 1.5);
hold on;
semilogx(f_range, db(mag_th), 'DisplayName', 'Teorico', 'LineWidth', 1.5);
grid on;
xlabel('Frequenza [Hz]');
ylabel('Ampiezza [dB]');
legend('Sperimentale', 'Teorico: 1 gdl','Location', 'southwest');
title('\textbf{Diagramma di Bode del modulo}','Interpreter','latex');
hold off


subplot(2,1,2)
semilogx(Bodesp.f, Bodesp.phi*180/pi, 'DisplayName', 'Sperimentale', 'LineWidth', 1.5);
hold on;
semilogx(f_range, phase_th, 'DisplayName', 'Teorico', 'LineWidth', 1.5);
ylim([-180 180])
grid on;
xlabel('Frequenza [Hz]');
ylabel('\Delta\phi [°]','Interpreter','tex');
legend('Sperimentale', 'Teorico: 1 gdl','Location', 'northwest');
title('\textbf{Diagramma di Bode della fase}','Interpreter','latex');

%% Teorico sovrasmorzato
xi=1.1;

c=xi*2*sqrt(k*m);

% stati [y; y_dot]
A=[0 1;
  -k/m -c/m];
space=ss(A,B,C,D);
G11=tf(space);
f_range = logspace(1, 2.5, 1000); % frequency range for Bode plot
[mag_th_11, phase_th_11] = bode(G11, f_range*2*pi);


% Converto il vettore 3D in una dimensione
mag_th_11 = squeeze(mag_th_11);
phase_th_11 = squeeze(phase_th_11);

Bodeconfronto=figure;
subplot(2,1,1)
semilogx(Bodesp.f, db(Bodesp.A), 'DisplayName', 'Sperimentale', 'LineWidth', 1.5);
hold on;
semilogx(f_range, db(mag_th_11), 'DisplayName', 'Teorico', 'LineWidth', 1.5);
grid on;
xlabel('Frequenza [Hz]');
ylabel('Ampiezza [dB]');
legend('Sperimentale', 'Teorico: 1 gdl','Location', 'Best');
title('\textbf{Diagramma di Bode del modulo: $\xi =1.1$}','Interpreter','latex');
hold off


subplot(2,1,2)
semilogx(Bodesp.f, Bodesp.phi*180/pi, 'DisplayName', 'Sperimentale', 'LineWidth', 1.5);
hold on;
semilogx(f_range, phase_th_11, 'DisplayName', 'Teorico', 'LineWidth', 1.5);
ylim([-180 180])
grid on;
xlabel('Frequenza [Hz]');
ylabel('\Delta\phi [°]','Interpreter','tex');
legend('Sperimentale', 'Teorico: 1 gdl','Location', 'northwest');
title('\textbf{Diagramma di Bode della fase: $\xi =1.1$}','Interpreter','latex');

%% Banda passante
% Attenuamento massimo: +-15%
At_max=0.85;
Amp_max2=1.15;

banda=figure;
semilogx(Bodesp.f, db(Bodesp.A), 'DisplayName', 'Sperimentale', 'LineWidth', 1.5);
hold on
semilogx(f_range, db(mag_th), 'DisplayName', 'Teorico','LineWidth', 1.5);
semilogx(f_range, db(At_max)*ones(length(f_range)),'LineWidth',1.5,'Color','g');
semilogx(f_range, db(Amp_max2)*ones(length(f_range)),'LineWidth',1.5,'Color','g');
legend('Sperimentale', 'Teorico: 1gdl, $\xi=0.0515$','Limiti di attenuazione','Location', 'northwest','interpreter','latex');
grid on
hold off

% Main contributor: Simone Benassi