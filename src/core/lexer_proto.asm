SECTION .data

SECTION .bss
code_len        equ     5 
operation_len   equ     10   
operation       resq    operation_len
code            resq    code_len
operand         resq    code_len
opcode          resq    code_len

SECTION .text
analyze_prepare:                        ;подготовка к анализу
        push    esi    
        xor     eax,eax
        mov     esi, 0 
        mov     ebx, 0
        mov     ebx,[buffer]

lexer_prepare:                          ;подготовка к чтению буфера
        cmp     byte [ebx+esi], 0       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; todo: check is it realy works
        je      analyze_done
        push    eax
        push    ebx
        push    ecx
        push    edx
        mov     ecx,ebx
        mov     eax,4
        mov     ebx,1
        mov     ebx,1
        mov     edx,1
        int     80h
        inc     esi
        pop     eax
        pop     ebx
        pop     ecx
        pop     edx
        jmp     lexer_prepare

lexer_opcode:

