%% Analisi delle incertezze
clear
close all
clc
%incertezze strumenti
wcen=0.001; %incertezza centralina (0.1%)
wcal=1*1e-5; %incertezza calibro [m]
wi=0.05*pi/180; %incertezza inclinometro [rad]
g=9.81;
wrig=0.5e-3; %[mm]
%Spessore
spes=[1.23 1.31 1.19 1.22 1.40]; %[mm]

VM_spes=mean(spes)*10^-3; %[m]
STD_spes=std(spes)*10^-3; %[m]
%Diametro
dim=[19.99 20.07]; %[mm]

VM_dim=mean(dim)*10^-3; %[m]
STD_dim=std(dim)*10^-3; %[m]

% calcolo incertezze statistiche
ustat_s=STD_spes/sqrt(length(spes));  %[m]
uspes_s=wcal/sqrt(3); %hp distriuzione uniforme-->scarto tipo [m]
utot_s=sqrt(uspes_s^2+ustat_s^2); %[m]

ustat_d=STD_dim/sqrt(length(dim));
uspes_d=wcal/sqrt(3); %hp distriuzione uniforme-->scarto tipo
utot_d=sqrt(uspes_d^2+ustat_d^2);
%misura=VM+utot

%% Pura torsione- Quarter Bridge

load('PT_QB_12cm.dat');
load('PT_QB_14cm.dat');

% Angolo con l'orizzontale
theta=32.5*pi/180; % [rad] 

%calcolo errore singoli momenti
M=length(PT_QB_12cm(:,1));
wM_qb_twelve_pt=0;
for n=1:M
wM_qb_twelve_pt_sin=inctot(theta,VM_dim,12,PT_QB_12cm(n,1),wi,utot_d,wrig);
wM_qb_twelve_pt=wM_qb_twelve_pt+wM_qb_twelve_pt_sin^2;
wM_qb_twelve_pt_plot(n)=wM_qb_twelve_pt_sin;
end
wM_qb_twelve_pt=sqrt(wM_qb_twelve_pt); %[Nm]

M=length(PT_QB_14cm(:,1));
wM_qb_fourteen_pt=0;

for n=1:M
wM_qb_fourteen_pt_sin=inctot(theta,VM_dim,14,PT_QB_14cm(n,1),wi,utot_d,wrig);
wM_qb_fourteen_pt=wM_qb_fourteen_pt+wM_qb_fourteen_pt_sin^2;
wM_qb_fourteen_pt_plot(n)=wM_qb_fourteen_pt_sin;
end
wM_qb_fourteen_pt=sqrt(wM_qb_fourteen_pt); %[Nm]

%calcolo incertezza coefficiente angolare

% Forza applicata
PT.QB.force.twelve=g*(1e-3.*PT_QB_12cm(:,1)); % m*g [N]
PT.QB.force.fourteen=g*(1e-3.*PT_QB_14cm(:,1)); % m*g [N]

% Momento applicato %braccio misura+ raggio provino
PT.QB.momento.twelve=(VM_dim/2+12e-2)*PT.QB.force.twelve*cos(theta); %[Nm]
PT.QB.momento.fourteen=(VM_dim/2+14e-2)*PT.QB.force.fourteen*cos(theta); %[Nm]

% Unisco i dati
PT.QB.momenti_tot=[PT.QB.momento.twelve;PT.QB.momento.fourteen]; %[Nm]
PT.QB.def=[PT_QB_12cm(:,2);PT_QB_14cm(:,2)]; %[um]


wM_qb_pt=[wM_qb_twelve_pt wM_qb_fourteen_pt]; %unione incertezza momenti [Nm]

N=length(PT_QB_14cm(:,2))+length(PT_QB_12cm(:,2)); %numero ripetizione esperimenti
wM_pt_qb=sqrt(sum((wM_qb_pt).^2)); %RSS per l'errore totale sul momento [Nm]

wM_qb_pt_plot=[wM_qb_twelve_pt_plot wM_qb_fourteen_pt_plot];

PT.QB.k=polyfit(PT.QB.momenti_tot,PT.QB.def,1); %coefficiente angolare e off-set
k_pt_qb=PT.QB.k(1); %coefficiente angolare [um/Nm]
[wk_qb_pt, wdef_qb_pt]=incertezza_ca(wM_pt_qb,PT.QB.momenti_tot,N,PT.QB.def,wcen,k_pt_qb,wM_qb_pt_plot); %incertezza sul coeff angolare [um/Nm] e sulla deformazione [um]

%plot delle incertezze
figure

errorbar(PT.QB.momenti_tot, polyval(PT.QB.k,PT.QB.momenti_tot), wdef_qb_pt);
hold on
errorbar(PT.QB.momenti_tot, polyval(PT.QB.k,PT.QB.momenti_tot),wM_qb_pt_plot,'horizontal')
title("Incertezze quarto di ponte-pura torsione")
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \epsilon]$','Interpreter','latex')
hold off

%% Pura torsione- Full Bridge
load('PT_FB_10cm.dat');
load('PT_FB_11cm.dat');
load('PT_FB_12cm.dat');
load('PT_FB_14cm.dat');

% Angolo con l'orizzontale
theta=32.5*pi/180; % [rad]

%calcolo errore singoli momenti
M=length(PT_FB_10cm(:,1));
wM_fb_ten_pt=0;
for n=1:M
wM_fb_ten_pt_sin=inctot(theta,VM_dim,10,PT_FB_10cm(n,1),wi,utot_d,wrig);
wM_fb_ten_pt=wM_fb_ten_pt+wM_fb_ten_pt_sin^2;
wM_fb_ten_pt_plot(n)=wM_fb_ten_pt_sin;
end
wM_fb_ten_pt=sqrt(wM_fb_ten_pt); %[Nm]

M=length(PT_FB_11cm(:,1));
wM_fb_eleven_pt=0;
for n=1:M
wM_fb_eleven_pt_sin=inctot(theta,VM_dim,11,PT_FB_11cm(n,1),wi,utot_d,wrig);
wM_fb_eleven_pt=wM_fb_eleven_pt+wM_fb_eleven_pt_sin^2;
wM_fb_eleven_pt_plot(n)=wM_fb_eleven_pt_sin;
end
wM_fb_eleven_pt=sqrt(wM_fb_eleven_pt); %[Nm]

M=length(PT_FB_12cm(:,1));
wM_fb_twelve_pt=0;
for n=1:M
wM_fb_twelve_pt_sin=inctot(theta,VM_dim,12,PT_FB_12cm(n,1),wi,utot_d,wrig);
wM_fb_twelve_pt=wM_fb_twelve_pt+wM_fb_twelve_pt_sin^2;
wM_fb_twelve_pt_plot(n)=wM_fb_twelve_pt_sin;
end
wM_fb_twelve_pt=sqrt(wM_fb_twelve_pt); %[Nm]

M=length(PT_FB_14cm(:,1));
wM_fb_fourteen_pt=0;
for n=1:M
wM_fb_fourteen_pt_sin=inctot(theta,VM_dim,14,PT_FB_14cm(n,1),wi,utot_d,wrig);
wM_fb_fourteen_pt=wM_fb_fourteen_pt+wM_fb_fourteen_pt_sin^2;
wM_fb_fourteen_pt_plot(n)=wM_fb_fourteen_pt_sin;
end
wM_fb_fourteen_pt=sqrt(wM_fb_fourteen_pt); %[Nm]

%calcolo incertezza coefficiente angolare
% Forza applicata
PT.FB.force.ten=g*(1e-3.*PT_FB_10cm(:,1)); % m*g [N]
PT.FB.force.eleven=g*(1e-3.*PT_FB_11cm(:,1)); % m*g [N]
PT.FB.force.twelve=g*(1e-3.*PT_FB_12cm(:,1)); % m*g [N]
PT.FB.force.fourteen=g*(1e-3.*PT_FB_14cm(:,1)); % m*g [N]

% Momento applicato
PT.FB.momento.ten=(VM_dim/2+10e-2)*PT.FB.force.ten*cos(theta); %[Nm]
PT.FB.momento.eleven=(VM_dim/2+11e-2)*PT.FB.force.eleven*cos(theta); %[Nm]
PT.FB.momento.twelve=(VM_dim/2+12e-2)*PT.FB.force.twelve*cos(theta); %[Nm]
PT.FB.momento.fourteen=(VM_dim/2+14e-2)*PT.FB.force.fourteen*cos(theta); %[Nm]

% Unisco i dati
PT.FB.momenti_tot=[PT.FB.momento.ten;PT.FB.momento.eleven; PT.FB.momento.twelve;PT.FB.momento.fourteen]; %[Nm]
PT.FB.def=[PT_FB_10cm(:,2);PT_FB_11cm(:,2);PT_FB_12cm(:,2);PT_FB_14cm(:,2)]; %[um]

wM_fb_pt=[wM_fb_ten_pt wM_fb_eleven_pt wM_fb_twelve_pt wM_fb_fourteen_pt]; %unione incertezza momenti [Nm]

N=length(PT_FB_14cm(:,2))+length(PT_FB_12cm(:,2))+length(PT_FB_11cm(:,2))+length(PT_FB_10cm(:,2)); %numero ripetizione esperimenti
wM_pt_fb=sqrt(sum((wM_fb_pt).^2)); %RSS per l'errore totale sul momento [Nm]
wM_fb_pt_plot=[wM_fb_ten_pt_plot wM_fb_eleven_pt_plot wM_fb_twelve_pt_plot wM_fb_fourteen_pt_plot];

PT.FB.k=polyfit(PT.FB.momenti_tot,PT.FB.def,1); %coefficiente angolare e off-set
k_pt_fb=PT.FB.k(1); %coefficiente angolare [um/Nm]

[wk_fb_pt, wdef_fb_pt]=incertezza_ca(wM_pt_fb,PT.FB.momenti_tot,N,PT.FB.def,wcen,k_pt_fb,wM_fb_pt_plot); %incertezza sul coefficiente angolare [um/Nm] e sulle deformazioni [um]

%plot delle incertezze
figure

errorbar(PT.FB.momenti_tot, polyval(PT.FB.k,PT.FB.momenti_tot), wdef_fb_pt);
hold on
errorbar(PT.FB.momenti_tot, polyval(PT.FB.k,PT.FB.momenti_tot),wM_fb_pt_plot,'horizontal')
title("Incertezze full bridge-pura torsione")
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \epsilon]$','Interpreter','latex')
hold off

%% Trave incastrata: QB
load("IS_QB_1cm.dat");
load("IS_QB_9cm.dat");
load("IS_QB_12cm.dat");

% Angolo con l'orizzontale
theta=0; % [rad]

%calcolo errore singoli momenti
M=length(IS_QB_1cm(:,1));
wM_qb_one_is=0;
for n=1:M
wM_qb_one_is_sin=inctot(theta,VM_dim,1,IS_QB_1cm(n,1),wi,utot_d,wrig);
wM_qb_one_is=wM_qb_one_is+wM_qb_one_is_sin^2;
wM_qb_one_is_plot(n)=wM_qb_one_is_sin;
end
wM_qb_one_is=sqrt(wM_qb_one_is); %[Nm]

M=length(IS_QB_9cm(:,1));
wM_qb_nine_is=0;
for n=1:M
wM_qb_nine_is_sin=inctot(theta,VM_dim,9,IS_QB_9cm(n,1),wi,utot_d,wrig);
wM_qb_nine_is=wM_qb_nine_is+wM_qb_nine_is_sin^2;
wM_qb_nine_is_plot(n)=wM_qb_nine_is_sin;
end
wM_qb_nine_is=sqrt(wM_qb_nine_is); %[Nm]

M=length(IS_QB_12cm(:,1));
wM_qb_twelve_is=0;
for n=1:M
wM_qb_twelve_is_sin=inctot(theta,VM_dim,12,IS_QB_12cm(n,1),wi,utot_d,wrig);
wM_qb_twelve_is=wM_qb_twelve_is+wM_qb_twelve_is_sin^2;
wM_qb_twelve_is_plot(n)=wM_qb_twelve_is_sin;
end
wM_qb_twelve_is=sqrt(wM_qb_twelve_is); %[Nm]

%calcolo incertezza coefficiente angolare
% Forza applicata
IS.QB.force.one=g*(1e-3.*IS_QB_1cm(:,1)); % m*g [N]
IS.QB.force.nine=g*(1e-3.*IS_QB_9cm(:,1)); % m*g [N]
IS.QB.force.twelve=g*(1e-3.*IS_QB_12cm(:,1)); % m*g [N]

% Momento applicato
IS.QB.momento.one=(VM_dim/2+1e-2)*IS.QB.force.one; % [Nm]
IS.QB.momento.nine=(VM_dim/2+9e-2)*IS.QB.force.nine; % [Nm]
IS.QB.momento.twelve=(VM_dim/2+12e-2)*IS.QB.force.twelve; % [Nm]

% Unisco i dati
IS.QB.momenti_tot=[IS.QB.momento.one;IS.QB.momento.nine;IS.QB.momento.twelve]; %[Nm]
IS.QB.def=[IS_QB_1cm(:,2);IS_QB_9cm(:,2);IS_QB_12cm(:,2)]; %[um]

wM_qb_is=[wM_qb_one_is wM_qb_nine_is wM_qb_twelve_is]; %unione incertezza momenti [Nm]

N=length(IS_QB_12cm(:,2))+length(IS_QB_9cm(:,2))+length(IS_QB_1cm(:,2)); %numero ripetizione esperimenti
wM_is_qb=sqrt(sum((wM_qb_is).^2)); %RSS per l'errore totale sul momento [Nm]
wM_qb_is_plot=[wM_qb_one_is_plot wM_qb_nine_is_plot wM_qb_twelve_is_plot];

IS.QB.k=polyfit(IS.QB.momenti_tot,IS.QB.def,1); %coefficiente angolare e off-set
k_is_qb=IS.QB.k(1); %coefficiente angolare [um/Nm]

[wk_qb_is, wdef_qb_is]=incertezza_ca(wM_is_qb,IS.QB.momenti_tot,N,IS.QB.def,wcen,k_is_qb,wM_qb_is_plot); %incertezza sul coefficiente angolare [um/Nm] e sulle deformazioni [um]

%plot delle incertezze
figure

errorbar(IS.QB.momenti_tot, polyval(IS.QB.k,IS.QB.momenti_tot), wdef_qb_is);
hold on
errorbar(IS.QB.momenti_tot, polyval(IS.QB.k,IS.QB.momenti_tot),wM_qb_is_plot,'horizontal')
title("Incertezze quarto di ponte-trave incastrata")
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \epsilon]$','Interpreter','latex')
hold off

%% Trave incastrata: FB

load("IS_FB_1cm.dat");
load("IS_FB_9cm.dat");
load("IS_FB_11cm.dat");
load("IS_FB_13cm.dat");

% Angolo con l'orizzontale
theta=0; % [rad]

%calcolo errore singoli momenti
M=length(IS_FB_1cm(:,1));
wM_fb_one_is=0;
for n=1:M
wM_fb_one_is_sin=inctot(theta,VM_dim,1,IS_FB_1cm(n,1),wi,utot_d,wrig);
wM_fb_one_is=wM_fb_one_is+wM_fb_one_is_sin^2;
wM_fb_one_is_plot(n)=wM_fb_one_is_sin;
end
wM_fb_one_is=sqrt(wM_fb_one_is); %[Nm]

M=length(IS_FB_9cm(:,1));
wM_fb_nine_is=0;
for n=1:M
wM_fb_nine_is_sin=inctot(theta,VM_dim,9,IS_FB_9cm(n,1),wi,utot_d,wrig);
wM_fb_nine_is=wM_fb_nine_is+wM_fb_nine_is_sin^2;
wM_fb_nine_is_plot(n)=wM_fb_nine_is_sin;
end
wM_fb_nine_is=sqrt(wM_fb_nine_is); %[Nm]

M=length(IS_FB_11cm(:,1));
wM_fb_eleven_is=0;
for n=1:M
wM_fb_eleven_is_sin=inctot(theta,VM_dim,11,IS_FB_11cm(n,1),wi,utot_d,wrig);
wM_fb_eleven_is=wM_fb_eleven_is+wM_fb_eleven_is_sin^2;
wM_fb_eleven_is_plot(n)=wM_fb_eleven_is_sin;
end
wM_fb_eleven_is=sqrt(wM_fb_eleven_is); %[Nm]

M=length(IS_FB_13cm(:,1));
wM_fb_thirteen_is=0;
for n=1:M
wM_fb_thirteen_is_sin=inctot(theta,VM_dim,13,IS_FB_13cm(n,1),wi,utot_d,wrig);
wM_fb_thirteen_is=wM_fb_thirteen_is+wM_fb_thirteen_is_sin^2;
wM_fb_thirteen_is_plot(n)=wM_fb_thirteen_is_sin;
end
wM_fb_thirteen_is=sqrt(wM_fb_thirteen_is); %[Nm]
%calcolo incertezza coefficiente angolare
% Forza applicata
IS.FB.force.one=g*(1e-3.*IS_FB_1cm(:,1)); % m*g [N]
IS.FB.force.nine=g*(1e-3.*IS_FB_9cm(:,1)); % m*g [N]
IS.FB.force.eleven=g*(1e-3.*IS_FB_11cm(:,1)); % m*g [N]
IS.FB.force.thirteen=g*(1e-3.*IS_FB_13cm(:,1)); % m*g [N]

% Momento applicato
IS.FB.momento.one=(VM_dim/2+1e-2)*IS.FB.force.one; % [Nm]
IS.FB.momento.nine=(VM_dim/2+9e-2)*IS.FB.force.nine; % [Nm]
IS.FB.momento.eleven=(VM_dim/2+11e-2)*IS.FB.force.eleven; % [Nm]
IS.FB.momento.thirteen=(VM_dim/2+13e-2)*IS.FB.force.thirteen; % [Nm]

% Unisco i dati
IS.FB.momenti_tot=[IS.FB.momento.one;IS.FB.momento.nine;IS.FB.momento.eleven;IS.FB.momento.thirteen]; %[Nm]
IS.FB.def=[IS_FB_1cm(:,2);IS_FB_9cm(:,2);IS_FB_11cm(:,2);IS_FB_13cm(:,2)]; %[um]

wM_fb_is=[wM_fb_one_is wM_fb_nine_is wM_fb_eleven_is wM_fb_thirteen_is]; %unione incertezza momenti [Nm]

N=length(IS_FB_13cm(:,2))+length(IS_FB_11cm(:,2))+length(IS_FB_9cm(:,2))+length(IS_FB_1cm(:,2)); %numero ripetizione esperimenti
wM_is_fb=sqrt(sum((wM_fb_is).^2)); %RSS per l'errore totale sul momento [Nm]
wM_fb_is_plot=[wM_fb_one_is_plot wM_fb_nine_is_plot wM_fb_eleven_is_plot wM_fb_thirteen_is_plot];

IS.FB.k=polyfit(IS.FB.momenti_tot,IS.FB.def,1); %coefficiente angolare e off-set
k_is_fb=IS.FB.k(1); %coefficiente angolare [um/Nm]

[wk_fb_is, wdef_fb_is]=incertezza_ca(wM_is_fb,IS.FB.momenti_tot,N,IS.FB.def,wcen,k_is_fb,wM_fb_is_plot); %incertezza sul coefficiente angolare [um/Nm] e deformazioni

%plot delle incertezze
figure

errorbar(IS.FB.momenti_tot, polyval(IS.FB.k,IS.FB.momenti_tot), wdef_fb_is);
hold on
errorbar(IS.FB.momenti_tot, polyval(IS.FB.k,IS.FB.momenti_tot),wM_fb_is_plot,'horizontal')
title("Incertezze full bridge-trave incastrata")
xlabel('M [Nm]')
ylabel(' Deformazione $[\mu \epsilon]$','Interpreter','latex')
hold off

%% Function

function [w]=inctot(theta,VM_dim,br,M,wtheta,wdim,wbr)
%theta:angolo di inclinazione del braccio [rad]
%VM_dim:valor medio del diametro [m]
%br:braccio [cm]
%M:massa attaccata al braccio [g]
%wtheta:incertezza su theta [rad]
%wdim:incertezza sul diametro [m]
%wbr:incertezza sul brazzio [m]


%calcolo incertezza per i momenti
g=9.81; %[m/s]
br=br*1e-2; %[cm]-->[m]
%incertezze tipo
udim=wdim/sqrt(3);
ubr=wbr/sqrt(3);
utheta=wtheta/sqrt(3);
%uso RSS
wm=(0.5*g*M*1e-3*cos(theta)*udim)^2+(g*(M*1e-3)*cos(theta)*ubr)^2+...
   +((0.5*VM_dim+br)*g*(M*1e-3)*sin(theta)*utheta)^2;
w=sqrt(wm); %[Nm]
end

function [wk,wdef_plot]=incertezza_ca(wM,M,N,def,wcen,k,wM_sin)
%wM:incertezza sui momenti [Nm]
%M:momenti [Nm]
%N:numero totale di prove 
%def:deformazione [um]
%wcen:incertezza sul valore della centralina [um]
%k:coefficiente angolare [m/Nm]

%calcolo incertezza coefficiente angolare-->RSS su coefficiente angolare
I=sum(M.^2);
VM_M=sum(M)/length(M);
%calcolo wdef
wdef=[];
wdef_plot=ones(length(def),1);
for n=1:length(def)
    wdef=[wdef (wcen*def(n)/sqrt(3))]; %[um]
    wdef_plot(n)=sqrt(wdef(n)^2+(k*wM_sin(n))^2); %[um]
end
wdef=sqrt(sum(wdef.^2)); %[um]

wdef_eq=sqrt(wdef^2+(k*wM)^2); %propagazione dell'errore dovuta dall'incertezza del momento [um]

wk=wdef_eq*sqrt(1/(I-(N*VM_M.^2))); %[um/Nm]
end


%% Main contributor: Federica Beccaria




