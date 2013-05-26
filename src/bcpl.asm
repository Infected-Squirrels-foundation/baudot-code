;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;								;;
;;		Baudot Code Programming Language		;;
;;			----------------			;;
;;		 by Infected Squirrel Foundation		;;
;;								;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Some info will be posted here. 				;;
;;								;;
;;								;;
;;								;;
;;								;;
;;						    John Smith	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION .data
usage		db 0xa
		db "Baudot Code Programming Language",0xa
		db "Version: 0.1",0xa
		db 0xa
		db "Usage:",0xa
		db "./bcpl <code>",0xa
		db 0xa
		db "Developed by Infected Squirrel Foundation",0xa
		db "Distributed under GNU\GPL v2 licence",0xa
		db 0xa
ulen		equ $-usage
errmsg		db "Error.", 0xa
errmsg_len	equ $-errmsg

SECTION .bss
buffer_len	resq	20
buffer		resq	262144

SECTION .text
global _start

%include "out.asm"
%include "core/init.asm"
%include "core/lexer.asm"
%include "core/translator.asm"

_start:
	pop	ecx			;argc
	call	checkargc		;does we receive code or just souless exec
	pop	ecx 			;argv 0
	pop	ecx			;argv 1
	mov	ebx, ecx
	push	esi
	mov	esi, ebx

count_len:
	cmp	byte [esi], 0		;if equal zero byte
	je	prepare			;stop counting and prepare to analyze
	inc	esi			;else increment esi
	jmp	count_len		;and try again
prepare:
	sub	esi, ebx
	mov	dx, si
	pop	esi

	mov	[buffer],ecx		;time to save values(code)
	mov	[buffer_len],ebx	;(code real length)

;	call	_output
	call	analyze_prepare
end:
	mov	eax, 1
	mov	ebx, 0
	int	80h
