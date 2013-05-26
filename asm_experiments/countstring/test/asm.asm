SECTION .data
len equ 5
msg db "dafuq"
SECTION .bss
lout resq len
SECTION .text
global _y

_y:
	mov esi, 5
	mov [lout], byte "1"
	mov [lout+1], byte "2"
	mov [lout+2], byte "1"
	mov [lout+3], byte "1"
	mov [lout+4], byte "0"
	mov [lout+esi], byte "a"
	cmp byte[lout+1], "0"
	jne end
	mov eax, 4
	mov ebx, 1
	mov ecx, lout
	mov edx, 6
	int 80h
end:
	mov eax, 1
	mov ebx, 0
	int 80h
