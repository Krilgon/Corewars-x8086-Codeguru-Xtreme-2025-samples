;main core for program based on 2024 second place champion




MIN_VALUE_CS equ 0x5b0
REP_SIZE equ 0x20 


main:

    mov bp,  0xfc

    mov bx, 0xfc

    mov cx, REP_SIZE

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

    xor si, si
    

    
    
    mov di, ax
    
    jmp first_callfar
    
replicator:
    
    
    ;# REP MOVSW 
    rep movsw
    
  first_callfar:

    add di, 0xf20
    
    mov sp, di
    sub sp, 0xfd

    mov ax, di 

    xor al, al


    mov cl, 0x4
    shr ax, cl

    add ax, MIN_VALUE_CS

    mov cx, di
    mov ch, 0xA5

    mov [bx+0x2], ax
    mov [bx], cx

    mov ax, 0xec29
    STOSW
    mov ax, 0x1fff
    STOSW

    sub di, 0x3

    mov cx, REP_SIZE

    xor si, si

    call far [bx]