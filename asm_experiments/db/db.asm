SECTION .data
test 	db 0x55

SECTION .text
global _st

_st:
	mov eax, 4
	mov ebx, 1
	mov ecx, test
	mov edx, 2
	int 80h
	mov eax, 1
	mov ebx, 0
	int 80h
