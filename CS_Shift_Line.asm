;main core for program based on 2024 second place champion but with Line-callfar tactics






BOMBING_AREA_SHIFT equ 0x61f0
BOMBING_AREA_SIZE equ 0x300 - 0x1

DI_SHIFT equ BOMBING_AREA_SHIFT + BOMBING_AREA_SIZE - 0x1
LAST_BYTE_ZERO_MASK equ 0xFFF0
MIN_VALUE_CS equ 0x5b0
REP_SIZE equ 0x12


main:

    mov bl, 0x40

    mov cx, REP_SIZE + 0x3 ;# REP_SIZE + сдвиг, чтобы щаписать call far

    mov si, ax
    add si, replicator
    rep movsw

    push cs
    push es
    push cs

    pop es
    pop ds
    pop ss

    mov sp, ax
    

    mov si, jump_destination - replicator
    
    mov bp, BOMBING_AREA_SIZE;# BP = BOMBING_AREA_SIZE
    mov dx, DI_SHIFT;# DX = DI_SHIFT
    
    
    mov di, ax    
    
    
    jmp first_callfar
    
replicator:

    rep movsw
    
  first_callfar:
    

    sub di, dx
    and di, LAST_BYTE_ZERO_MASK    
    

    lea sp, [bp+di]

    mov ax, di 

    xor al, al


    mov cl, 0x4
    shr ax, cl

    add ax, MIN_VALUE_CS
    mov [bx+0x2], ax


    
    mov [bx], di
    mov byte [bx + 1], 0xa5
    

    movsw


    dec di


    mov cl, REP_SIZE
    

    xor si, si
    

    call far [bx]

nop


jump_destination:
    call far [bx]