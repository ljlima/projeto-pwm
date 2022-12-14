//Projeto fonte chaveada

///Dados de entrada
Vac=220  //Tensao entrada nominal
Vacmin=205  //Tensao entrada minima
Vacmax=230 //Tensao entrada maxima

f=60       //Frequência
Vcmin=100   //Tensão retificada minima
n=0.7   //Rendimento
Pout=300    //potencia de saida desejada
QuedaDiodo=5//Queda de tensao no diodo

//Potencia de entrada 
Pin=Pout/n

//Tensao Pk 
Vpk=sqrt(2)*Vacmin

//Delta V
deltaV=Vpk-Vcmin

//Capacitores necessários a partir do equivalente

C=Pin/(f*deltaV*deltaV)

C1=2*C
C2=2*C

//Intervalo de condução dos diodos e tempo de recarga dos capacitores

tc=(acos(Vcmin/Vpk))/(2*%pi*f)

//Quantidade de carga transferida ao capacitor

deltaQ=C*deltaV

//Calculo do pico de corrente no intervalo de recarga do capacitor
Ip=deltaQ/tc

//Calculo da corrente eficaz no capacitor equivalente
T=1/f
a=(2*tc/T)
Iec=Ip*sqrt(a-a*a)

//Corrente para carga para razao ciclica 1/2 (D=0,5)
i2cf=Pin/Vcmin

//Corrente eficaz componente alternada
Icef=sqrt(i2cf*i2cf + Iec*Iec)

//Corrente eficaz no diodo
IDef=Ip*sqrt(tc/T)

//corrente média pelos diodos
IDmed=Pin/(2*Vcmin)




