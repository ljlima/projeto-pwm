disp('-------------retificador trifasico')
Pout=300   // Potencia saida
Vlcf=220    //Tensao de entrada de linha RMS
Vlpico=sqrt(2)*Vlcf //Tensao de pico
f=60        //Frequencia
Vcmin=290   //Tensão minima do ripple
w=2*%pi*f

C=Pout/(6*f*(Vlpico^2-Vcmin^2))//Valor do capacitor

Icp = w*C*sqrt(Vlpico^2-Vcmin^2)    //Corrente maxima no capacitor
Ir= Pout/Vlpico //corrente de pico na carga
Iin=Icp+Ir  //Corrente de pico na entrada
disp('Capacitor', C*1000*1000, 'uF')
disp('Corrente pico nos diodos', Iin, 'A')
disp('Corrente Pico no capacitor', Icp, 'A')

disp('-------------Limitador da corrente do capacitor no inicio')

R1=100      //Resistencia antes do retificador
Ipico_entrada=Vlpico/R1
//C=15e-6     //Valor do capacitor de retificação
//Tempo em que o triac deve ficar aberto para permitir o resistor limitar a corrente
t=15*R1*C
disp('Tempo de Abertura do Triac', t, 's')

disp('------------PARTE DO FILTRO DE SAIDA-----------------')
//Filtro de saida 
Fch=2000//Frequencia chaveamento dos transistores
fsaida=2*Fch
fCorte= fsaida*0.1*2*%pi //modulacao três níveis
fAmort=0.707
    
R=88    //Modelagem do motor
Cfiltro=1/(2*fAmort*R)
Lfiltro=1/(fCorte^2*C)
disp('Capacitor Filtro', Cfiltro)
disp('Indutor Filtro', Lfiltro*1000, 'mH')
disp('Freq. corte Filtro', fCorte, 'HZ')
