;main core program/ it catches the 1 zombie and provides code for both of zombies




VAR_SHIFT_CS equ -0xa
VAR_SHIFT_CS_ZOMB_1 equ 0x3
VAR_SHIFT_CS_ZOMB_2 equ 0x5

VAR_BOMBING_AREA_SHIFT equ 0x6200
VAR_BOMBING_AREA_SIZE equ 0x300

VAR_BOMBING_AREA_SHIFT_ZOMB equ 0x3100

BX_SHIFT_1 equ 0x40
BX_SHIFT_2 equ 0x50
BX_SHIFT_ZOMB_2 equ 0x50
REP_SIZE equ 0x7

COMP_SP_SHIFT equ VAR_BOMBING_AREA_SHIFT - VAR_BOMBING_AREA_SIZE
COMP_SP_SHIFT_ZOMB equ VAR_BOMBING_AREA_SHIFT_ZOMB - VAR_BOMBING_AREA_SIZE

COMP_CS_SHIFT equ VAR_SHIFT_CS*0x10
COMP_NEW_CS equ 0x1000 + VAR_SHIFT_CS

COMP_CS_SHIFT_ZOMB_1 equ VAR_SHIFT_CS_ZOMB_1*0x10
COMP_NEW_CS_ZOMB_1 equ 0x1000 + VAR_SHIFT_CS_ZOMB_1

COMP_CS_SHIFT_ZOMB_2 equ VAR_SHIFT_CS_ZOMB_2*0x10
COMP_NEW_CS_ZOMB_2 equ 0x1000 + VAR_SHIFT_CS_ZOMB_2




jmp hunt_zomb_1

; TODO: thrash


hunt_zomb_1:
    mov si, ax

    lea bp, [si + united_zomb]

    nop ; -
    nop ; -
    ; --- 6
    mov dx, [0x1243]
    ; --- 6
    xor ax, ax
    push es
    push cs
    pop es

    mov bx, 0x10e1
    div bx

    mov di, ax
    mov [0x0], bp

    mov ax, 0x24FF
    mov dx, 0x24FF

    INT 0x86
    nop
    lea ax, [si + start_surv_2]
    mov [0x0], ax ; но 0 
    pop es
    sub ax, start_surv_2
    xor di, di
    mov [0x0], word 0xCCCC  
    

    jmp core

united_zomb:
    mov ax, [si]
    mov si, ax
    MOV BP, VAR_BOMBING_AREA_SHIFT_ZOMB
    MOV DX, COMP_SP_SHIFT_ZOMB


    cmp cx, 0x0
    jnz zomb1

zomb2:
        ADD SI, replicator - united_zomb; -------
        MOV CL, REP_SIZE + 0x2
        
        xor di, di
        push ss 
        pop es

        
        REP MOVSW
        ; свап сегментов
        MOV BX, BX_SHIFT_ZOMB_2

      
        PUSH ES
        POP DS

        
        add ax, target - COMP_CS_SHIFT_ZOMB_2 - united_zomb; ------- 


        MOV [BX], AX ; записываем target для IP
        MOV WORD [BX + 0x2], COMP_NEW_CS_ZOMB_2 ; записываем будующий CS
        
    mov_ax_axSurv2:
        mov ax, 0x0

        add ah, 0x6
        
        call far [bx]



zomb1:

    ADD SI, replicator- united_zomb
    MOV CL, REP_SIZE + 2
    REP MOVSW
    

    MOV BX, BX_SHIFT_1 ; по BX будут лежать координаты прыжка call far 
    
    ; свап сегментов
    PUSH ES
    POP DS


    add ax, target - COMP_CS_SHIFT_ZOMB_1  - united_zomb      

    MOV [BX], AX ; записываем IP для target
    MOV WORD [BX + 0x2], COMP_NEW_CS_ZOMB_1
    add ah, 0x6
    call far [bx]


start_surv_2:
    mov bx, [0x0]
    mov [bx + mov_ax_axSurv2+1- start_surv_2], si
    mov ax, bx
    MOV BX, BX_SHIFT_2
    MOV BP, VAR_BOMBING_AREA_SHIFT
    MOV DX, COMP_SP_SHIFT

    PUSH ES
    POP DS


    add ax, target - COMP_CS_SHIFT  - start_surv_2      

    MOV [BX], AX ; записываем IP для target
    MOV WORD [BX + 0x2], COMP_NEW_CS
    mov ax, si

    call far [bx]




core:  
    ADD SI, replicator
    MOV CL, REP_SIZE + 2
    REP MOVSW
    

    MOV BX, BX_SHIFT_1
    MOV BP, VAR_BOMBING_AREA_SHIFT
    MOV DX, COMP_SP_SHIFT

    ; свап сегментов
    PUSH ES
    POP DS


    add ax, target - COMP_CS_SHIFT      

    MOV [BX], AX
    MOV WORD [BX + 0x2], COMP_NEW_CS
    call far [bx]
    
target:

    PUSH CS
    POP ES
    
    POP CX
    POP SS
   
    
    MOV AL, 0xA3
    MOV [BX], AX


    MOV SP, AX 
    ADD SP, VAR_BOMBING_AREA_SIZE
    

    MOV DI, AX
    


        

    MOV CX, REP_SIZE
    
    mov si, jump_destination - replicator
    
    movsw
    DEC DI

    XOR SI, SI 

    JMP [BX]

replicator:
    REP MOVSW
    
    SUB [BX], BP
    SUB SP, DX
    MOV DI, [BX]
    movsw

    DEC DI
    XOR SI, SI
    MOV CL, REP_SIZE
    JMP [bx]


jump_destination:
    call far [bx]
