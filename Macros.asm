WriteAllNotifications MACRO

;==================== INSTRUCTIONS ====================;

    MOV     AL, 0
    MOV     BX, 000Eh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET INSTRUCT4+1
    MOV     DH, 0                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR INSTRUCT4         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

    MOV     AL, 0
    MOV     BX, 0003h                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET INSTRUCT1+1
    MOV     DH, 2                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR INSTRUCT1         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

    MOV     AL, 0
    MOV     BX, 0003h                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET INSTRUCT2+1
    MOV     DH, 3                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR INSTRUCT2         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

    MOV     AL, 0
    MOV     BX, 0003h                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET INSTRUCT3+1
    MOV     DH, 4                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR INSTRUCT3         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

    MOV     AL, 0
    MOV     BX, 0005h                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET INSTRUCT5+1
    MOV     DH, 5                 ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR INSTRUCT5         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER


;==================== EDITOR ====================;

    MOV     AL, 0
    MOV     BX, 000Eh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET EDITORTITLE+1
    MOV     DH, 7                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR EDITORTITLE         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

;==================== CONSOLE ====================;

    MOV     AL, 0
    MOV     BX, 000Eh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET CONSOLETITLE+1
    MOV     DH, 30                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR CONSOLETITLE         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

;==================== Game Status ====================;

    MOV     AL, 0
    MOV     BX, 000Eh                      ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET GAMESTATUSTITLE+1
    MOV     DH, 40                         ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR GAMESTATUSTITLE   ;No OF CHAR IN STRING
    INT     10h                            ;WRITE LETTER 

ENDM WriteAllNotifications


;=====================================================================================================================;
DrawVerticalLine MACRO X

DRAWLOOP:

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET Dot+1
    MOV     DH, LinePosY                  ;ROW(Y)
    MOV     DL, X                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR Dot          ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER 

    INC     LinePosY
    CMP     LinePosY , 50
    JB      DRAWLOOP

ENDM DrawVerticalLine

;=====================================================================================================================;
DrawBlackSquare MACRO X , Y
    LOCAL DRAWLOOP

    MOV CX , X
    MOV DX , Y
    MOV AH , 0CH
    MOV al , 0

    MOV BX , X
    ADD BX , resolution   ;SQUARE RESOLUTION

    MOV DI , Y
    ADD DI , resolution   ;SQUARE RESOLUTION

DRAWLOOP: 
    INT 10H

    INC CX        ;INC COLUMN
    CMP BX ,CX    
    JNZ DRAWLOOP  

    MOV CX , X
    INC DX        ;INC ROW
    CMP DI , DX   
    JNZ DRAWLOOP   

ENDM DrawBlackSquare   

;=====================================================================================================================;
DrawObject MACRO X , Y , COLOR
    LOCAL DRAWLOOP

    MOV CX , X
    MOV DX , Y
    MOV AH , 0CH
    MOV SI , COLOR

    MOV BX , X
    ADD BX , resolution   ;SQUARE RESOLUTION

    MOV DI , Y
    ADD DI , resolution   ;SQUARE RESOLUTION

DRAWLOOP: 
    LODSB
    INT 10H

    INC CX        ;INC COLUMN
    CMP BX ,CX    
    JNZ DRAWLOOP  

    MOV CX , X
    INC DX        ;INC ROW
    CMP DI , DX   
    JNZ DRAWLOOP   

ENDM DrawObject   

;==============================================   ANIMATIONS   =========================================================;

AnimateEggMOV MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET:

    MOV eggMOVOldPosY , DX

    ADD Y , resolution

    DrawObject eggMOVPosX , eggMOVPosY , eggMOVSprite

    DrawBlackSquare X , eggMOVOldPosY


ENDM AnimateEggMOV

AnimateEggAH MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET2

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET2:

    MOV eggAHOldPosY , DX

    ADD Y , resolution

    DrawObject eggAHPosX , eggAHPosY , eggAHSprite

    DrawBlackSquare X , eggAHOldPosY


ENDM AnimateEggAH

AnimateEggTWO MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET3

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET3:

    MOV eggTWOOldPosY , DX

    ADD Y , resolution

    DrawObject eggTWOPosX , eggTWOPosY , eggTWOSprite

    DrawBlackSquare X , eggTWOOldPosY


ENDM AnimateEggTWO

AnimateEggDL MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET4

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET4:

    MOV eggDLOldPosY , DX

    ADD Y , resolution

    DrawObject eggDLPosX , eggDLPosY , eggDLSprite

    DrawBlackSquare X , eggDLOldPosY


ENDM AnimateEggDL

AnimateEggLETTERA MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET5

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET5:

    MOV eggLETTERAOldPosY , DX

    ADD Y , resolution

    DrawObject eggLETTERAPosX , eggLETTERAPosY , eggLETTERASprite

    DrawBlackSquare X , eggLETTERAOldPosY


ENDM AnimateEggLETTERA

AnimateEggINT MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET6

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET6:

    MOV eggINTOldPosY , DX

    ADD Y , resolution

    DrawObject eggINTPosX , eggINTPosY , eggINTSprite

    DrawBlackSquare X , eggINTOldPosY


ENDM AnimateEggTWENTYONE

AnimateEggTWENTYONE MACRO X , Y

    MOV DX , Y

    CMP  DX , MaxPosY
    JNA  NORESET7

    MOV DI , OriginalPosY
    MOV Y , DI

NORESET7:

    MOV eggTWENTYONEOldPosY , DX

    ADD Y , resolution

    DrawObject eggTWENTYONEPosX , eggTWENTYONEPosY , eggTWENTYONESprite

    DrawBlackSquare X , eggTWENTYONEOldPosY


ENDM AnimateEggTWENTYONE

;=====================================================================================================================;

DrawPlayer MACRO X , Y

    DrawObject playerPosX , playerPosY , playerSprite

ENDM DrawPlayer

;=====================================================================================================================;

AnimatePlayer MACRO X , Y


ENDM AnimatePlayer

;===========================================    IN GAME WRITTEN    ==================================================;

WriteFirstMOV MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET FIRSTMOV+1
    MOV     DH, 10                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR FIRSTMOV         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteFirstMOV

WriteLose MACRO

    MOV     AL, 0
    MOV     BX, 000Ch                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET LOSEWORDS+1
    MOV     DH, 42                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR LOSEWORDS         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteLose

WriteWIN MACRO

    MOV     AL, 0
    MOV     BX, 0002h                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WINWORDS+1
    MOV     DH, 42                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WINWORDS         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteWIN


WriteAX MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WORDAX+1
    MOV     DH, 10                  ;ROW(Y)
    MOV     DL, 96                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WORDAX         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteAX

WriteTWO MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WORDTWO+1
    MOV     DH, 10                  ;ROW(Y)
    MOV     DL, 100                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WORDTWO         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteTWO

WriteSECONDMOV MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET FIRSTMOV+1
    MOV     DH, 12                  ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR FIRSTMOV         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteSECONDMOV

WriteDL MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WORDDL+1
    MOV     DH, 12                  ;ROW(Y)
    MOV     DL, 96                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WORDDL         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteDL

WriteLETTERA MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET LETTERA+1
    MOV     DH, 12                  ;ROW(Y)
    MOV     DL, 100                        ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR LETTERA         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteLETTERA

WriteINT MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WORDINT+1
    MOV     DH, 14                 ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WORDINT         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteINT

WriteTWENTYONE MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET WORDTWENTYONE+1
    MOV     DH, 14                 ;ROW(Y)
    MOV     DL, 96                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR WORDTWENTYONE        ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteTWENTYONE

WriteACONSOLE MACRO

    MOV     AL, 0
    MOV     BX, 000Fh                     ;COLOR
    MOV     AH, 13h
    MOV     BP, OFFSET ACONSOLE+1
    MOV     DH, 32                 ;ROW(Y)
    MOV     DL, 92                         ;COLUMN(X)
    MOV	    CH, 0
    MOV     CL, BYTE PTR ACONSOLE         ;No OF CHAR IN STRING
    INT     10h                           ;WRITE LETTER

ENDM WriteACONSOLE


;=====================================================================================================================;
