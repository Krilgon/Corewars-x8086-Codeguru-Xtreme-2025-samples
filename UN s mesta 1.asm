;special anti-callfar tactic (line callfars), very effective against line-callfars (which are practically around 85% of other contestants), but too useless against other survivors


REP_SIZE equ 0x7


_1_VAR_START_PLACE equ 0x80A1 ; _ _ A 1
_1_VAR_SHIFT_CS equ 0xA2
_1_VAR_BOMBING_AREA_SIZE equ 0x600


_1_BX_SHIFT equ 0x60

_1_COMP_SP_EX_SHIFT_TO_A5 equ 0x0
_1_COMP_SP_SHIFT equ -_1_VAR_BOMBING_AREA_SIZE
_1_COMP_CS_SHIFT equ _1_VAR_SHIFT_CS*0x10
_1_COMP_NEW_CS equ 0x1000 + _1_VAR_SHIFT_CS


_2_VAR_START_PLACE equ 0x80A9 ; _ _ A 9
_2_VAR_SHIFT_CS equ 0xA5
_2_VAR_BOMBING_AREA_SIZE equ 0x600

_2_BX_SHIFT equ 0x40

_2_COMP_SP_EX_SHIFT_TO_A5 equ 0x2
_2_COMP_SP_SHIFT equ -_2_VAR_BOMBING_AREA_SIZE
_2_COMP_CS_SHIFT equ _2_VAR_SHIFT_CS*0x10
_2_COMP_NEW_CS equ 0x1000 + _2_VAR_SHIFT_CS


_1ZOMB_VAR_START_PLACE equ 0x7AA1 ; _ _ A 1
_2ZOMB_VAR_START_PLACE equ 0x7AA9 ; _ _ A 9


;====================================
;       SURVIVOR 1
;====================================
start_surv_1:

zomb_hunting_int87:
    std
    push ES

    ; ES на поле
    push CS
    pop ES

    mov si, ax

    add ax, zomb_1
    mov [0x0], ax 


    mov ax, 0x0ffe
    mov dx, 0xf9eb

    mov cx, 0x24FF 
    mov bx, cx

    int 0x87


    lea ax, [si + start_surv_2]
    pop ES
    cld


preperation_for_surv2_jmp:
    mov di, _2_BX_SHIFT
    stosw
    sub ax, start_surv_2
    xor di, di


    mov bp, _1_VAR_START_PLACE

A5_main:
    MOV SI, AX
    ADD WORD SI, replicator
    mov CX, REP_SIZE + 3
    REP MOVSW
    

    MOV BX, _1_BX_SHIFT 
    
    
    ; свап сегментов
    PUSH ES
    POP DS


    add ax, A5_target - _1_COMP_CS_SHIFT      

    MOV [BX], AX 
    MOV WORD [BX + 0x2], _1_COMP_NEW_CS 
    call far [bx]
A5_target:
    PUSH CS
    POP ES
    
    POP si 
    POP SS
   
   
    mov ax, bp
    
    MOV [BX], AX 
   

    
    MOV DI, AX
    
    MOV SP, DI 
    sub WORD SP, _1_VAR_BOMBING_AREA_SIZE - _1_COMP_CS_SHIFT + _1_COMP_SP_EX_SHIFT_TO_A5
    
    MOV DX, _1_COMP_SP_SHIFT

    MOV CL, REP_SIZE
    
    mov si, jump_destination - replicator
    
    movsw
    movsw
    
    sub di, 0x3

    XOR SI, SI 
    
    mov ax, 0x14
    mov bp, 0x3
    JMP [BX]

replicator:
    REP MOVSW
    
    add SP, DX
    
    MOV DI, [BX]
    
    movsw
    movsw
    sub di, bp
    XOR SI, SI
    
    MOV CL, REP_SIZE
    JMP [bx]


jump_destination:
    add sp, ax
    call far [bx]



;====================================
;       SURVIVOR 2
;====================================

;---------
start_surv_2:
    mov ax, [bx]
    sub ax, start_surv_2
    mov bp, _2_VAR_START_PLACE
    jmp AB_start_surv_2

;---------


AB_main:
    MOV SI, AX
    ADD WORD SI, replicator
    mov CX, REP_SIZE + 3
    REP MOVSW
    

    MOV BX, _1_BX_SHIFT 
    
    
    ; свап сегментов
    PUSH ES
    POP DS


AB_start_surv_2:

    add ax, AB_target - _2_COMP_CS_SHIFT     

    MOV [BX], AX 
    MOV WORD [BX + 0x2], _2_COMP_NEW_CS 
    call far [bx]
AB_target:
    PUSH CS
    POP ES
    
    POP si 
    POP SS
   

    mov ax, bp 
    
    MOV [BX], AX 
   

    
    MOV DI, AX 
    
    MOV SP, DI 
    sub WORD SP, _2_VAR_BOMBING_AREA_SIZE - _2_COMP_CS_SHIFT + _2_COMP_SP_EX_SHIFT_TO_A5
    

    MOV DX, _2_COMP_SP_SHIFT
        

    MOV CL, REP_SIZE
    
    mov si, jump_destination - replicator
    
    movsw
    movsw
    
    sub di, 0x3

    XOR SI, SI 
        
    mov ax, 0x14
    mov bp, 0x3
    JMP [BX]



;====================================
;       ZOMBIE 1
;====================================

zomb_1:
    mov ax, [0x0]
    sub ax, zomb_1


    call hunt_zomb_2
    
    push SS
    pop ES

    xor di, di

    mov bp, _2ZOMB_VAR_START_PLACE
    jmp AB_main

    jmp $

hunt_zomb_2:
    mov si, ax

    lea bp, [si + zomb_2]
    nop 
    nop
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
    INT 0x86
    ret

;====================================
;       ZOMBIE 2
;====================================

zomb_2:
    jmp $
    mov ax, [0x0]

    push SS
    pop ES

    xor di, di





    mov bp, _1ZOMB_VAR_START_PLACE
    sub ax, zomb_2
    jmp A5_main

    jmp $





