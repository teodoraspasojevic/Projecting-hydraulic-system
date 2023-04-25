%% Projektni zadatak iz HPS-a

clear;
close all;
clc;

%% inicijalizacija parametara

Bp = 30;
K = 0;
Ap = 1.4*(10^(-2));
Mt = 11;
Vt = 4*(10^(-3));
Kc = 1.8*(10^(-12));
Ctp = 3*(10^(-13));
Kq = 1;
Kt = 6.8*(10^(-2));
Kf = 2.5*(10^(3));
R = 10;
r = 0.02;
Be = 13*(10^(8));
Umax = 24;

m = 180;
k = 2*(10^(6));
b = 150;
L = 1.2;
T = 1.5;
r1 = 0.3;

a_max= 10/3;
v_max = a_max*0.2*T;

g = 9.81;

%% matrica A

a21 = -2*(k+K)/(2*Mt+9*m);
a22 = -2*(b+Bp)/(2*Mt+9*m);
a23 = 2*Ap/(2*Mt+9*m);
a24 = 2*k/(2*Mt+9*m);
a25 = 2*b/(2*Mt+9*m);

a32 = -Ap*4*Be/Vt;
a33 = -4*Be*(Kc+Ctp)/Vt;

a51 = k*6/(7*m);
a52 = b*6/(7*m);
a54 = -k*6/(7*m);
a55 = -b*6/(7*m);

A = [0 1 0 0 0; a21 a22 a23 a24 a25; 0 a32 a33 0 0; 0 0 0 0 1; a51 a52 0 a54 a55];

%% matrica B

b31 = Kq*Kt*4*Be/(Vt*R*r*Kf);

B = [0 0 b31 0 0]';

%% matrica C

C = [1 0 0 0 0];

%% matrica H

h51 = (6/7)*g;

H = [0 0 0 0 h51]';

%% funkcija prenosa

s = tf('s');

G = C*(s*eye(5)-A)^(-1)*B;

%% crtanje nula i polova i step odziva

figure(1)
    pzmap(G);

figure(2)
    step(G);
    title('Odskocni odziv sistema u otvorenoj sprezi');
    grid on;
    
figure(3)
    step(G/(1+G));
    title('Odskocni odziv sistema u zatvorenoj sprezi');
    grid on;

%% pokretanje simulacije

sim('projekat_56.slx');

%% nalazenje maksimalne sile i hoda i brzine klipa/klipnjace

xp = z1.Data;
xp_dot = z2.Data;
xp_2dot = z2_dot.Data;
y = z4.Data;
y_dot = z5.Data;

F1 = k.*(xp - y) + b.*(xp_dot - y_dot);
F1_max = max(abs(F1));

Fl = (9/2).*m.*xp_2dot + F1;
Fl_max = max(abs(Fl));

h = max(z1.Data);
v = max(z2.Data);

disp(F1_max);
disp(Fl_max);
disp(h);
disp(v);

%% odredjivanje parametara

d = 32*10^(-3);
eta_cf = 0.9;
eta_vol = 0.95;
eta_m = 0.8;
n = 2000/60;
p = 160*(10^5);

Ap = Fl_max/p/eta_cf;
D = sqrt(4*Ap/pi + d^2);

disp(Ap);
disp(D);

Ap1 = D^2*pi/4;
Q = Ap1*v;
V = Q/n/eta_vol;

disp(Q);
disp(V);

P = p*Q/eta_m/eta_vol;

disp(P);