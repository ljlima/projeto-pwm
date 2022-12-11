	list p=16f628a		;define o tipo de uC usado
	#include <p16f628.inc>	;inclui declarações típicas
	;diretiva para definir a palavra de configuração
	__CONFIG _HS_OSC&_WDT_OFF&_PWRTE_ON&_BODEN_OFF&_LVP_OFF

;DEFINIÇÃO DAS PORTAS A SEREM USADAS=============================================================
#define Ac1 PORTB, RB0
#define Ac2 PORTB, RB1
#define Ac3 PORTB, RB2
#define Ac4 PORTB, RB3
#define Ac5 PORTB, RB4
#define Ac6 PORTB, RB5
;=================================================================================================
	ORG 	0X00
;Definição do endereço inicial do programa
	ORG 0X04
	
setup: 
	bsf		STATUS, RP0	;Entra no banco1
	clrf	TRISB		;Coloca porta b como saida
	bcf		STATUS, RP0	;Sai do banco1
	cblock 0X20
		contador1, contador2, contador3
	endc
;Ideia inicial Chaveamento
;
;Inicio
;	defina todas as portas em nível baixo
;	
;	1°COMUTACAO========================================================================
;	No tempo t=0
;	Ac5 <- high
;	Ac6 <- low		Nesse caso seria a onda defasada em -120°, ja viria com nivel alto de t=-infinito
;	
;		
;	Ac1 <- high		inicio da onda com defasagem zero (Va)
;	Ac2 <- low
;	
;	2°COMUTACAO========================================================================
;
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;
;	Ac5 <- low
;	Ac6 <- hig
;
;	3°COMUTACAO========================================================================
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;
;	Ac3 <- high
;	Ac4 <- low
;	
;	4°COMUTACAO========================================================================
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;
;	Ac1 <- low
;	Ac2 <- high
;	
;	5°COMUTACAO========================================================================
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;	
;	Ac5 <- high
;	Ac6 <- low	
;	
;	6°COMUTACAO========================================================================
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;	
;	Ac3 <- low
;	Ac4 <- high	
;	
;	7°COMUTACAO========================================================================
;	Espere T/3		-seria 1/3 do periodo do duty cycle
;	
;	Ac1 <- high		inicio da onda com defasagem zero (Va)
;	Ac2 <- low
;	
;	FIM DO CICLO	
;

main:
	;Vindo de t = - infinito......
	call aciona_VG3
	call aciona_VG1
	
	;call delay_333us
	call	delay_5ms
	;call delay_um_terco_de_T		;Considerar T = duty_cycle
	nop
	nop
	nop
	call desaciona_VG3
	
	;call delay_um_terco_de_T
	;call delay_333us
	call	delay_5ms
	nop
	nop
	nop
	call aciona_VG2
	nop
	nop
	nop
	;call delay_um_terco_de_T
	;call delay_333us
	call	delay_5ms
	nop
	nop
	nop
	call desaciona_VG1
	nop
	nop
	nop
	;call delay_um_terco_de_T
	;call delay_333us
	call	delay_5ms
	nop
	nop
	nop
	call aciona_VG3	
	nop
	nop
	nop
	;call delay_um_terco_de_T
	;call delay_333us
	call	delay_5ms
	nop
	nop
	nop
	call desaciona_VG2
	nop
	nop
	nop
	;call delay_um_terco_de_T
	;call delay_333us
	call	delay_5ms
	nop
	nop
	nop
	call aciona_VG1
	goto main + .2

;======Funções para acionamento das portas 

aciona_VG1:	
	bsf		Ac1
	nop
	nop
	nop
	nop
	bcf		Ac2
	nop
	nop
	nop
	nop
	return

aciona_VG2:	
	bsf		Ac3
	nop
	nop
	nop
	nop
	bcf		Ac4
	nop
	nop
	nop
	nop
	return

aciona_VG3:	
	bsf		Ac5
	nop
	nop
	nop
	nop	
	bcf		Ac6
	nop
	nop
	nop
	nop	
	return

desaciona_VG1:	
	bcf		Ac1
	nop
	nop
	nop
	nop	
	bsf		Ac2
	nop
	nop
	nop
	nop
	return

desaciona_VG2:	
	bcf		Ac3
	nop
	nop
	nop
	nop
	bsf		Ac4
	nop
	nop
	nop
	nop
	return

desaciona_VG3:	
	bcf		Ac5
	nop
	nop
	nop
	nop
	bsf		Ac6
	nop
	nop
	nop
	nop
	return




delay_333ms:
	MOVLW 0Xd7
	MOVWF contador1
	MOVLW 0Xc2
	MOVWF contador2
	MOVLW 0X07
	MOVWF contador3
LOOP
	DECFSZ contador1,1
	GOTO LOOP
	DECFSZ contador2,1
	GOTO LOOP
	DECFSZ contador3, 1
	GOTO LOOP
	RETURN

delay_5ms:
	MOVLW 0Xf7
	MOVWF contador1
	MOVLW 0X1a
	MOVWF contador2
LOOP1
	DECFSZ contador1, 1
	GOTO LOOP1
	DECFSZ contador2, 1
	GOTO LOOP1
	NOP
	NOP
	RETURN

delay_333us:
	MOVLW 0Xb8
	MOVWF contador1
	MOVLW 0X02
	MOVWF contador2
LOOP2
	DECFSZ contador1, 1
	GOTO LOOP2
	DECFSZ contador2, 1
	GOTO LOOP2
	NOP
	NOP
	RETURN

	END					; FIM DE PROGRAMA
