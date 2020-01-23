;https://www.tek-tips.com/viewthread.cfm?qid=963469 for clearing keyboard buffer
include Macros.asm

.MODEL LARGE
.STACK 64

.DATA 

include Data.asm

include Sprites.asm

.CODE

MAIN PROC FAR

        mov     AX, @DATA
        mov     DS, AX
        mov     ES, AX
        
        mov     eggMOVSprite, offset Sprite_EGGMOV
        MOV     EGGAHSPRITE , offset Sprite_EGGAH
        mov     playerSprite, offset Sprite_Player_0
        MOV     EGGTWOSPRITE , offset Sprite_EGGTWO
        MOV     EGGDLSPRITE , offset Sprite_EGGDL
        MOV     EGGLETTERASPRITE , offset Sprite_EGGLETTERA
        MOV     EGGINTSPRITE    , offset Sprite_EGGINT
        MOV     EGGTWENTYONESPRITE     , offset Sprite_EGGTWENTYONE

        ;VIDEO MODE
        mov     AX, 4F02H
        mov     BX, 0105H
        ;MOV     AH , 0
        ;MOV     AL , 13H       ;LOWER RESOLUTION VIDEO MODE
        INT     10H   

;-------------------------------------------------DRAW VERTICAL LINE------------------------------------------;

        DrawVerticalLine LinePosX

;-------------------------------------------------DRAW VERTICAL LINE------------------------------------------;

        WriteAllNotifications

;-------------------------------------------------DRAW PLAYER-------------------------------------------------;

        DrawPlayer playerPosX , playerPosY

;-------------------------------------------------First Frame-------------------------------------------------;


FIRSTFRAME:

        ;; 66 ms delay (CX:DX in microseconds)
        mov     CX, 0005h
        mov     DX, 046Ah
        mov     AH, 86h
        INT     15h

;-------------------------------------------------EGGS FALL--------------------------------------------------;

        AnimateEggMOV eggMOVPosX , eggMOVPosY 

        AnimateEggAH  eggAHPosX , eggAHPosY 

        AnimateEggTWO  eggTWOPosX , eggTWOPosY 

        AnimateEggDL  eggDLPosX , eggDLPosY 

        AnimateEggLETTERA  eggLETTERAPosX , eggLETTERAPosY 

        AnimateEggINT  eggINTPosX , eggINTPosY 

        AnimateEggTWENTYONE  eggTWENTYONEPosX , eggTWENTYONEPosY       

;-------------------------------------------------READ INPUT-------------------------------------------------;
READINPUT:

                MOV AH , 1
                INT 16H

ISRIGHT :       CMP AH , 4DH
                JNZ ISLEFT
                MOV DX , MaxPosX
                CMP playerPosX , DX
                JE  TEMPNOINPUT
                MOV DX , playerPosX
                MOV eggMOVOldPosX , DX
                ADD playerPosX , RESOLUTION
                MOV AH , 0
	        INT 16H                                 ;CLEAR BUFFER
                DrawPlayer playerPosX , playerPosY
                DrawBlackSquare eggMOVOldPosX , playerPosY

TEMPNOINPUT:
JMP NOINPUT

ISLEFT :        CMP AH , 4BH
                JNZ NOINPUT
                CMP playerPosX , 0
                JE  NOINPUT
                MOV DX , playerPosX
                MOV eggMOVOldPosX , DX
                SUB playerPosX , RESOLUTION
                MOV AH , 0
                INT 16H                                 ;CLEAR BUFFER
                DrawPlayer playerPosX , playerPosY                
                DrawBlackSquare eggMOVOldPosX , playerPosY

NOINPUT:

                mov ah,0cH
                mov al,0
                int 21h                                 ;CLEAR BUFFER

;-------------------------------------------------CHECK HIT AND POSITION-------------------------------------------------;

eggMOV:         
                MOV     AX , playerPosX
                CMP     AX , eggMOVPosX
                JNZ     eggAH

                MOV     AX , eggMOVPosY
                CMP     AX , 640
                JL     NOCOLLISIONTEMP1     
                
eggFIRSTMOV:      
                CMP     ORDER , 1
                JNZ     eggSecondMOV
                WriteFirstMOV
                INC     ORDER
                JMP     LOOPFRAME

eggSecondMOV:   
                CMP     ORDER , 4
                JNZ     LOSETEMP1
                WriteSECONDMOV
                INC     ORDER
                JMP     LOOPFRAME

NOCOLLISIONTEMP1:
JMP NOCOLLISION
eggAH:

                MOV     AX , playerPosX
                CMP     AX , eggAHPosX
                JNZ     EGGTWO

                MOV     AX , eggAHPosY
                CMP     AX , 640
                JL      NOCOLLISIONTEMP2

                CMP     ORDER ,2
                JNZ     LOSETEMP2
                WRITEAX
                INC ORDER
                JMP LOOPFRAME

LOSETEMP1:
JMP LOSE

EGGTWO:
                MOV     AX , playerPosX
                CMP     AX , eggTWOPosX
                JNZ     EGGDL

                MOV     AX , eggTWOPosY
                CMP     AX , 640
                JL      NOCOLLISIONTEMP3

                CMP     ORDER ,3
                JNZ     LOSETEMP3
                WRITETWO
                INC ORDER
                JMP LOOPFRAME

NOCOLLISIONTEMP2:
JMP NOCOLLISION                

LOSETEMP2:
JMP LOSE

EGGDL:
                MOV     AX , playerPosX
                CMP     AX , eggDLPosX
                JNZ     EGGLETTERA

                MOV     AX , eggDLPosY
                CMP     AX , 640
                JL      NOCOLLISIONTEMP4

                CMP     ORDER ,5
                JNZ     LOSETEMP4
                WRITEDL
                INC ORDER
                JMP LOOPFRAME

NOCOLLISIONTEMP3:
JMP NOCOLLISION

LOSETEMP3:
JMP LOSE

EGGLETTERA:

                MOV     AX , playerPosX
                CMP     AX , eggLETTERAPosX
                JNZ     EGGINT

                MOV     AX , eggLETTERAPosY
                CMP     AX , 640
                JL      NOCOLLISIONTEMP5

                CMP     ORDER ,6
                JNZ     LOSETEMP5
                WRITELETTERA
                INC ORDER
                JMP LOOPFRAME

NOCOLLISIONTEMP4:
JMP NOCOLLISION               

LOSETEMP4:
JMP LOSE

EGGINT:
                MOV     AX , playerPosX
                CMP     AX , eggINTPosX
                JNZ     EGGTWENTYONE

                MOV     AX , eggINTPosY
                CMP     AX , 640
                JL      NOCOLLISION

                CMP     ORDER ,7
                JNZ     LOSETEMP6
                WRITEINT
                INC ORDER
                JMP LOOPFRAME

NOCOLLISIONTEMP5:
JMP NOCOLLISION

LOSETEMP5:
JMP LOSE

EGGTWENTYONE:

                MOV     AX , playerPosX
                CMP     AX , eggTWENTYONEPosX
                JNZ     NOCOLLISION

                MOV     AX , eggTWENTYONEPosY
                CMP     AX , 640
                JL      NOCOLLISION

                CMP     ORDER ,8
                JNZ     LOSE
                WRITETWENTYONE
                JMP WIN

LOSETEMP6:
JMP LOSE

NOCOLLISION:
LOOPFRAME:

JMP     FIRSTFRAME

WIN:

WRITEACONSOLE
WRITEWIN

JMP ENDALL

LOSE:
                WriteLose

ENDALL:

MAIN ENDP
;========================================================================================================;

END MAIN