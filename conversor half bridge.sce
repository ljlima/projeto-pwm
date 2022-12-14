E=200
Np=20
Ns=20
Pout=300
T1=5e-3
T=16.66e-3
n=0.8
L=20e-6
fs=10e3  //Frequencia de comutacao
D=T1/T
Vout = (E/2)*(Ns/Np)*D
I0=Pout/Vout
Pin=Pout/n
Itr=3*Pout/E
Lp=(Np/Ns)^2*L
fr=fs/4
C=4/(%pi^2*fs^2*(Np/Ns)^2*L)

Vcmax=I0*(Ns)/(4*Np*fs*C)
deltaVc=2*Vcmax
//Se    0,05E< deltaVc < 0,1E, está adequado


Cmin= (Ns*I0)/(Np*2*fs*deltaVc)

disp('Capacitor = ', C*1000 ,'uF')
disp('Capacitor min = ', Cmin*1000 ,'uF')
disp('Corrente nos mosfets/transistores = ', Itr ,'A')
disp('Corrente SAIDA = ', I0 ,'A')
disp('Tensao SAIDA = ', Vout ,'V')
