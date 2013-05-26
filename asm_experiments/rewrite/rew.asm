SECTION .data
var	db "test"
com	db "lolq"
SECTION .text
global _start
_start:
	pop	eax
	pop	eax
	pop	eax
	mov	[var], eax
	cmp	eax,com
	je	yes

	mov	eax,1
	mov	ebx,0
	int	80h
	mov	eax,4
	mov	ebx,1
	mov	ecx,[var]
	mov	edx,4
	int	80h
	mov	eax,1
	mov	ebx,0
	int	80h
yes:
	mov	eax,4
	mov	ebx,1
	mov	ecx,[var]
	mov	edx,4
	int	80h
	mov	eax,1
	mov	ebx,0
	int	80h
