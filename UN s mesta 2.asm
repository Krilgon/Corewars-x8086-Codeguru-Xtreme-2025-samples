_2_BX_SHIFT equ 0x40

jmp zomb_hunting_int87

zomb_hunting_int87:
    std
    push ES

    ; ES на поле
    push CS
    pop ES



    mov ax, 0x0ffe
    mov dx, 0xf9eb

    mov cx, 0x24FF
    mov bx, cx

    int 0x87
    xor cx, cx
    cld


    mov bx, _2_BX_SHIFT
    POP DS
    
    nop
    nop
    nop
    nop

    jmp [_2_BX_SHIFT]
