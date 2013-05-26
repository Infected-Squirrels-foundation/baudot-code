checkargc:
        cmp     ecx,1
        je      help
        ret

help:
        mov     eax, 4
        mov     ebx, 1
        mov     ecx, usage
        mov     edx, ulen
        int     80h
        jmp     end


