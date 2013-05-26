SECTION .data
string db "test", 0xa
don	db "done",0xa

SECTION .bss
num	resd 1
SECTION .text
global _count

_count:
	mov ecx, 0
	mov ebx, string
;	dec eax

;        mov eax, 4
 ;       mov ebx, 1
;	mov ecx, string
;	mov edx, 4
 ;       int 80h

  ;      mov eax, 1
   ;     mov ebx, 0
    ;    int 80h
trycount:
;	call done
	cmp byte[ebx], 0
	jz done
	inc ecx
	inc ebx
	jmp trycount

done:
;	push ecx
	mov [num], ecx
	mov eax, 4
	mov ebx, 1
;	pop ecx
	mov ecx, num
	mov edx, 4
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
