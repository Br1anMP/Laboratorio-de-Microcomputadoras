PROCESSOR 16f877
INCLUDE <p16f877.inc>

K	equ H'40'	;aux1
L	equ H'41'	;aux2
LIM equ H'42'	;aux limite 
BAND equ H'43'	;bandera orden

	ORG 0
	GOTO INICIO
	ORG 5
	
INICIO:  MOVLW H'2F'	
		 MOVWF LIM		; (LIM)<-- W lÍmite de la lista
		 MOVLW H'20'    ;  W<-- primer número
		 MOVWF FSR		; (FSR)<--W
		 MOVLW H'00'
		 MOVWF BAND		; (BAND)<--W '0'
		 
NUM1:	 MOVF INDF, W	; W<--INDF
		 MOVWF K		; (K)<--W
	
NUM2: INCF FSR			; FSR<--FSR+1
	  MOVF INDF, W 		; W<--INDF
	  
COMPARA: SUBWF K, W			; W<--(K-W)
	  	 BTFSC STATUS, C	;¿C=0?
	  	 GOTO ORDENA		; C=0 
	  	 GOTO FINAL		; c=1

ORDENA: MOVF INDF, W	; W<--INDF
	    MOVWF K			; (K)<--W
		DECF FSR		; FSR<--FSR+1
		MOVF INDF, W	; W<--INDF
		MOVWF L			; L<--W
		MOVF K, W		; W<--K 
		MOVWF INDF		
		
		INCF FSR		; FSR<--FSR+1
		MOVF L, W		; W<--L
		MOVWF INDF	

		MOVF INDF, W	; W<-- INDF
		MOVWF K			; K<--W
		
		MOVLW H'01' 
		MOVWF BAND		; BAND<--'1'

FINAL:		
		 ;comprueba que llegue al final de la lista		
		 MOVF LIM, W 		; W<--LIM
		 SUBWF FSR, W		; W<--(FSR-LIM)
	  	 BTFSS STATUS, C	; ¿C=0?
	  	 GOTO NUM1			; c=1 
	  	 
	  	 ;revisa que la lista este ordenada
		 MOVLW H'01'		; C=0 
 		 SUBWF BAND, W  	; W <-- (BAND - W)
		 BTFSS STATUS, C	; ¿C=0?
		 GOTO $				; C=1 
		 GOTO INICIO		; C=0 	 

		 END