SECTION .data
sta	dq "11011"
stb	dq "10011"

true	db "true"
fals	db "fals"

SECTION .text
global _equal

_equal:
	mov eax, [sta]
	cmp eax, [stb]
	jne no
	jmp last

last:
	mov eax, [sta+4]
	cmp eax, [stb+4]
	jne no
	jmp yes

no:
	mov eax, 4
	mov ebx, 1
	mov ecx, fals
	mov edx, 4
	int 80h
	jmp end

yes:
	mov eax, 4
	mov ebx, 1
	mov ecx, true
	mov edx, 4
	int 80h

end:
	mov eax, 1
	mov ebx, 0
	int 80h
