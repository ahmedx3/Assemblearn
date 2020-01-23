resolution      EQU     64

;; ----------------- Macros.asm ----------------- ;;

OriginalPosY    DW      0
MaxPosY         DW      resolution * 9
MaxPosX         DW      resolution * 10

;ORDER

ORDER           DW      1

;EGGMOV
eggMOVPosX      DW      0
eggMOVPosY      DW      64
eggMOVOldPosX   DW      ?
eggMOVOldPosY   DW      ?
eggMOVPosXF     DW      ?
eggMOVPosYF     DW      ?
eggMOVSprite    DW      ?

;EGGAX
eggAHPosX      DW      64*5
eggAHPosY      DW      64*2
eggAHOldPosX   DW      ?
eggAHOldPosY   DW      ?
eggAHPosXF     DW      ?
eggAHPosYF     DW      ?
eggAHSprite    DW      ?

;EGGTWO
eggTWOPosX      DW      64*3
eggTWOPosY      DW      64
eggTWOOldPosX   DW      ?
eggTWOOldPosY   DW      ?
eggTWOPosXF     DW      ?
eggTWOPosYF     DW      ?
eggTWOSprite    DW      ?

;EGGDL
eggDLPosX      DW      64*7
eggDLPosY      DW      64
eggDLOldPosX   DW      ?
eggDLOldPosY   DW      ?
eggDLPosXF     DW      ?
eggDLPosYF     DW      ?
eggDLSprite    DW      ?

;EGGLETTERA
eggLETTERAPosX      DW      64*2
eggLETTERAPosY      DW      0
eggLETTERAOldPosX   DW      ?
eggLETTERAOldPosY   DW      ?
eggLETTERAPosXF     DW      ?
eggLETTERAPosYF     DW      ?
eggLETTERASprite    DW      ?

;EGGINT
eggINTPosX      DW      64*10
eggINTPosY      DW      64*2
eggINTOldPosX   DW      ?
eggINTOldPosY   DW      ?
eggINTPosXF     DW      ?
eggINTPosYF     DW      ?
eggINTSprite    DW      ?

;EGGTWENTYONE
eggTWENTYONEPosX      DW      64*8
eggTWENTYONEPosY      DW      0
eggTWENTYONEOldPosX   DW      ?
eggTWENTYONEOldPosY   DW      ?
eggTWENTYONEPosXF     DW      ?
eggTWENTYONEPosYF     DW      ?
eggTWENTYONESprite    DW      ?

;Player(Basket)
playerPosX      DW      0
playerPosY      DW      resolution * 11
playerSprite    DW      ?

;;=========================== WRITEN THINGS ===========================;;

;Horizontal Line
LinePosX        DB      90
LinePosY        DW      0
Dot             DB      1 , "|"

;NOTIFICATION BAR
INSTRUCT1        DB      29,"Collect Eggs In Correct Order"
INSTRUCT2        DB      25,"To Print Letter 'A' Using"
INSTRUCT3        DB      17,"Assembly Language"
INSTRUCT4        DB      14,"Your Mission :"
INSTRUCT5        DB      13   ,"Start with AH"

EDITORTITLE      DB      8,"Editor :"
FIRSTMOV         DB      4,  "MOV "
WORDAX           DB      3 ,  " AH"
WORDTWO          DB      4    ," , 2"
WORDDL           DB      3    ," DL"
LETTERA           DB      6, " , 'A'"
WORDINT         DB          4   , "INT "
WORDTWENTYONE   DB            4  , " 21H"

CONSOLETITLE     DB      9,"Console :"

GAMESTATUSTITLE  DB      13,"Game Status :"
LOSEWORDS        DB       8  ,"YOU LOSE"
WINWORDS        DB       7  ,"YOU WIN"
ACONSOLE        DB         1 ,"A"

