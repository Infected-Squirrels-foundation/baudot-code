SECTION .bss
buff	resb	262144

SECTION .text
global _args

_args:
	pop ecx ;argc
	pop ecx ;argv 0
	pop ebx ;argv 1
	mov ecx, ebx
	push esi
	mov esi,ebx

repeat:
	cmp byte [esi], 0
	je done
	inc esi
	jmp repeat

done:
	sub esi,ebx
	mov ax,si
	pop esi
	mov dx, ax
	mov eax, 4
	mov ebx, 1
	int 0x80

	mov eax, 1
	mov ebx, 0
	int 0x80
