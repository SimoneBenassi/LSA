% LABORATIORIO 1 
% GRUPPO A - 01
clear
close all
clc

%% DATI PROVINO DELLA PROVA STATICA
g=9.81; % [ms-2]
m_empty=0.108; % massa a vuoto[kg]
D_ext=20.03e-3; % [m] + incertezza calibro
t_vec=1e-3*[1.23, 1.31, 1.19, 1.22, 1.40];
t_medio=mean(t_vec); % spessore[m]
D_int=D_ext-2*t_medio; % [m]
E=70*1e9; % modulo di elasticità[Pa]
nu=0.33;
G=E/(2*(1+nu)); %[Pa]
Jp=(pi/32)* (D_ext^4-D_int^4); % Momento di inerzia polare [m^4]
R=D_ext/2; % raggio est[m]

%% Pura torsione- Quarter Bridge
load('PT_QB_12cm.dat');
load('PT_QB_14cm.dat');

% Angolo con l'orizzontale
theta=32.5*pi/180; % [rad]

% Forza applicata
PT.QB.force.twelve=g*(1e-3.*PT_QB_12cm(:,1)); % m*g [N]
PT.QB.force.fourteen=g*(1e-3.*PT_QB_14cm(:,1)); % m*g [N]

% Momento applicato (braccio = braccio di misura + raggio provino)
PT.QB.momento.twelve=(R+12e-2)*PT.QB.force.twelve*cos(theta); %[Nm]
PT.QB.momento.fourteen=(R+14e-2)*PT.QB.force.fourteen*cos(theta); %[Nm]

% Unisco i dati
PT.QB.momenti_tot=[PT.QB.momento.twelve;PT.QB.momento.fourteen];
PT.QB.def=[PT_QB_12cm(:,2);PT_QB_14cm(:,2)];
v1=polyfit(PT.QB.momenti_tot,PT.QB.def,1);
% m1 = 12.0443  

% Plotto i dati raccolti e la retta di regressione
figure
plot(PT.QB.momento.twelve,PT_QB_12cm(:,2),'*')
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \varepsilon]$','Interpreter','latex')
hold on
title('Pura torsione-Quarter Bridge')
plot(PT.QB.momento.fourteen,PT_QB_14cm(:,2),'*');
plot(PT.QB.momenti_tot,polyval(v1,PT.QB.momenti_tot));
legend('braccio di misura: 12cm','braccio di misura: 14cm',Location='best');

%% Pura torsione- Full Bridge
load('PT_FB_10cm.dat');
load('PT_FB_11cm.dat');
load('PT_FB_12cm.dat');
load('PT_FB_14cm.dat');

% Angolo con l'orizzontale
theta=32.5*pi/180; % [rad]

% Forza applicata
PT.FB.force.ten=g*(1e-3.*PT_FB_10cm(:,1)); % m*g [N]
PT.FB.force.eleven=g*(1e-3.*PT_FB_11cm(:,1)); % m*g [N]
PT.FB.force.twelve=g*(1e-3.*PT_FB_12cm(:,1)); % m*g [N]
PT.FB.force.fourteen=g*(1e-3.*PT_FB_14cm(:,1)); % m*g [N]

% Momento applicato
PT.FB.momento.ten=(R+10e-2)*PT.FB.force.ten*cos(theta); %[Nm]
PT.FB.momento.eleven=(R+11e-2)*PT.FB.force.eleven*cos(theta); %[Nm]
PT.FB.momento.twelve=(R+12e-2)*PT.FB.force.twelve*cos(theta); %[Nm]
PT.FB.momento.fourteen=(R+14e-2)*PT.FB.force.fourteen*cos(theta); %[Nm]

% Unisco i dati
PT.FB.momenti_tot=[PT.FB.momento.ten;PT.FB.momento.eleven; PT.FB.momento.twelve;PT.FB.momento.fourteen];
PT.FB.def=[PT_FB_10cm(:,2);PT_FB_11cm(:,2);PT_FB_12cm(:,2);PT_FB_14cm(:,2)];
v2=polyfit(PT.FB.momenti_tot,PT.FB.def,1); 
% m2 = 12.1120  

% Plotto i dati raccolti e la retta di regressione
figure
plot(PT.FB.momento.ten,PT_FB_10cm(:,2),'*')
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \varepsilon]$','Interpreter','latex')
hold on
title('Full Bridge-pura torsione')
plot(PT.FB.momento.eleven,PT_FB_11cm(:,2),'*');
plot(PT.FB.momento.twelve,PT_FB_12cm(:,2),'*');
plot(PT.FB.momento.fourteen,PT_FB_14cm(:,2),'*');
plot(PT.FB.momenti_tot,polyval(v2,PT.FB.momenti_tot))
legend('braccio di misura: 10cm', 'braccio di misura: 11cm',...
    'braccio di misura: 12cm','braccio di misura: 14cm',Location='best');

%% Trave incastrata: Full Bridge
load("IS_FB_9cm.dat");
load("IS_FB_11cm.dat");
load("IS_FB_13cm.dat");

% Forza applicata
IS.FB.force.nine=g*(1e-3.*IS_FB_9cm(:,1)); % m*g [N]
IS.FB.force.eleven=g*(1e-3.*IS_FB_11cm(:,1)); % m*g [N]
IS.FB.force.thirteen=g*(1e-3.*IS_FB_13cm(:,1)); % m*g [N]

% Momento applicato
IS.FB.momento.nine=(R+9e-2)*IS.FB.force.nine; % [Nm]
IS.FB.momento.eleven=(R+11e-2)*IS.FB.force.eleven; % [Nm]
IS.FB.momento.thirteen=(R+13e-2)*IS.FB.force.thirteen; % [Nm]

% Unisco i dati
IS.FB.momenti_tot=[IS.FB.momento.nine;IS.FB.momento.eleven;IS.FB.momento.thirteen];
IS.FB.def=[IS_FB_9cm(:,2);IS_FB_11cm(:,2);IS_FB_13cm(:,2)];

% Calcolo i coefficienti della retta di regressione 
v3=polyfit(IS.FB.momenti_tot,IS.FB.def,1);
%  m3 = 10.6891 

% Plotto i dati raccolti e la retta di regressione
figure
plot(IS.FB.momento.nine,IS_FB_9cm(:,2),'*')
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \varepsilon]$','Interpreter','latex')
hold on
title('Full Bridge trave incastrata')
plot(IS.FB.momento.eleven,IS_FB_11cm(:,2),'*');
plot(IS.FB.momento.thirteen,IS_FB_13cm(:,2),'*');
plot(IS.FB.momenti_tot,polyval(v3,IS.FB.momenti_tot))
legend('braccio di misura: 9cm', 'braccio di misura: 11cm','braccio di misura: 13cm',Location='best');


%% Trave incastrata: Quarter Bridge
load("IS_QB_1cm.dat");
load("IS_QB_9cm.dat");
load("IS_QB_12cm.dat");

% Forza applicata
IS.QB.force.one=g*(1e-3.*IS_QB_1cm(:,1)); % m*g [N]
IS.QB.force.nine=g*(1e-3.*IS_QB_9cm(:,1)); % m*g [N]
IS.QB.force.twelve=g*(1e-3.*IS_QB_12cm(:,1)); % m*g [N]

% Momento applicato
IS.QB.momento.one=(R+1e-2)*IS.QB.force.one; % [Nm]
IS.QB.momento.nine=(R+9e-2)*IS.QB.force.nine; % [Nm]
IS.QB.momento.twelve=(R+12e-2)*IS.QB.force.twelve; % [Nm]
IS.QB.momento_tot=[IS.QB.momento.one;IS.QB.momento.nine;IS.QB.momento.twelve];

% Coefficienti delle rette di regressione (parte sperimentale)
m1=polyfit(IS.QB.momento.one-mean(IS.QB.momento.one),IS_QB_1cm(:,2)-mean(IS_QB_1cm(:,2)),1);
m9=polyfit(IS.QB.momento.nine-mean(IS.QB.momento.nine),IS_QB_9cm(:,2)-mean(IS_QB_9cm(:,2)),1);
m12=polyfit(IS.QB.momento.twelve-mean(IS.QB.momento.twelve),IS_QB_12cm(:,2)-mean(IS_QB_12cm(:,2)),1);

% Coefficienti delle rette di regressione (parte analitica)
Iyy=(pi/4)*((D_ext/2)^4 -(D_int/2)^4); % momento d'inerzia attorno all'asse longitudinale [m^4] 
L=7*1e-2;
pendenza=@(b) (R/(2*G*Jp)+0.5*L*R./(b*E*Iyy))*1e6;
m1_analitica=pendenza(R+1e-2);
m9_analitica=pendenza(R+9e-2);
m12_analitica=pendenza(R+12e-2);

% Confronto grafico braccio 1cm
figure
plot(IS.QB.momento.one,IS_QB_1cm(:,2),'*',IS.QB.momento.one,polyval(m1,IS.QB.momento.one),...
    IS.QB.momento.one,(m1_analitica).*IS.QB.momento.one);
legend('dati','retta regressione','retta analitica');
xlabel('M [Nm]'); ylabel('Deformazione $[\mu \varepsilon]$','Interpreter','latex');
title('Solo Incastro Quarter Bridge: b=1cm');

% Confronto grafico braccio 9cm
figure
plot(IS.QB.momento.nine,IS_QB_9cm(:,2),'*',IS.QB.momento.nine,polyval(m9,IS.QB.momento.nine),...
    IS.QB.momento.nine,m9_analitica.*IS.QB.momento.nine);
legend('dati','retta regressione','retta analitica');
xlabel('M [Nm]'); ylabel('Deformazione $[\mu \varepsilon]$','Interpreter','latex');
title('Solo Incastro Quarter Bridge: b=9cm');

% Confronto grafico braccio 12cm
figure
plot(IS.QB.momento.twelve,IS_QB_12cm(:,2),'*',IS.QB.momento.twelve,polyval(m12,IS.QB.momento.twelve),...
    IS.QB.momento.twelve,m12_analitica.*IS.QB.momento.twelve);
legend('dati','retta regressione','retta analitica');
xlabel('M [Nm]'); ylabel('Deformazione $[\mu \varepsilon]$','Interpreter','latex');
title('Solo Incastro Quarter Bridge: b=12cm');

%% Pura torsione - calcoli analitici
m_analitica=R/(2*G*Jp)*1e6;  % 28.7625

%% Verifica di deformazioni in campo elastico

% Individuo lo sforzo di taglio max a cui abbiamo sottoposto  il provino
A=[max(PT.QB.momenti_tot),max(PT.FB.momenti_tot),max(IS.FB.momenti_tot),...
    max(IS.QB.momento_tot)];
Mtorc_max=max(A);
tau_max=16*Mtorc_max/(pi*(D_ext^3-D_int^3)) *1e-6; % 8.1199[MPa]

% "Lo sforzo di taglio di snervamento ammissibile per l'alluminio varia a 
% seconda della lega e dello stato di lavorazione. In generale, le leghe 
% più resistenti come l'alluminio 7075 possono raggiungere sforzi di taglio 
% di snervamento superiori a 207 MPa, mentre le leghe più comuni come 
% l'alluminio 6061 possono avere valori intorno ai 207 MPa. Per un 
% alluminio 6060, lo sforzo di taglio di snervamento può essere intorno 
% ai 180 MPa". --> siamo quindi ampiamente in campo elastico 




