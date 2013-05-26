_output:
	mov 	eax, 4
	mov	ebx, 1
	mov	ecx, [buffer]
	mov	edx, [buffer_len]
	int	80h
	ret
