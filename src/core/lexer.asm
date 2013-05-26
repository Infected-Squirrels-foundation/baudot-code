;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                              ;;
;;              Baudot Code Programming Language                ;;
;;                      ----------------                        ;;
;;               by Infected Squirrel Foundation                ;;
;;                                                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Some info will be posted here.                              ;;
;;                                                              ;;
;;                                                              ;;
;;                                                              ;;
;;                                                              ;;
;;                                                  John Smith  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SECTION .data

SECTION .bss
code_len	equ	5
operation_len	equ	10
operation	resq	operation_len
code		resq	code_len
operand		resq	code_len
opcode		resq	code_len

SECTION .text
analyze_prepare:			;подготовка к анализу
	push	esi
	xor	eax,eax
	mov	esi, 0
	mov	ebx, 0
;	inc	esi
	mov	ebx,[buffer]
;	mov	ebx,buffer
;	mov	[eax],0

lexer_prepare:				;подготовка к чтению буфера
;	xor	esi, esi
;	inc	esi
;	call	lexer_opcode
	cmp	byte [ebx+esi], 0	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; todo: check is it realy works
	je	analyze_done
;	inc	[esi]
	push	eax
	push	ebx
	push	ecx
	push	edx
;	add	ebx,[eax]
;	mov	eax,[ebx+esi]
;	add	ebx,1
;	inc	bl
;	mov	[buffer], ebx
	mov	ecx,ebx
;	mov	ebx,ecx
	mov	eax,4
	mov	ebx,1
;	mov	ecx,[buffer+esi]
	mov	edx,1
	int	80h
	inc	esi
	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	jmp	lexer_prepare

lexer_opcode:
	push	esi
	push	eax
	push	ebx
	push	edx
	mov	eax,esi
	mov	edx,1
	mov	ebx,5
	idiv	ebx
	mov	cx,ax
	mov	eax,4
	mov	ebx,1
;	mov	ecx,ax
	mov	edx, 5
	int	80h
	cmp	ax, code_len
	je	translate_opcode
	pop	edx
	pop	ebx
	pop	eax
	pop	esi
	cmp	byte [ebx+esi], "1"
	je	opcode_one
	jmp	opcode_zero
lexer_operand:
	cmp	esi, operation_len
	je	translate_operand
	cmp	byte [ebx+esi], "1"
	je	operand_one
	jmp	operand_zero

opcode_one:
	mov	[opcode+esi], byte "1"
	jmp	lexer_opcode

opcode_zero:
	mov	[opcode+esi], byte "0"
	jmp	lexer_opcode

operand_one:
	mov	[operand+esi-5], byte "1"
	jmp	lexer_operand

operand_zero:
	mov	[operand+esi-5], byte "0"
	jmp	lexer_operand

;	add	eax,5
;	mov	[operation], ebx
;	mov	cx, [operation]
;	mov	cx, ddword[ax]
;	add	operation, 5
;	mov	cx, [operation]
;	mov	[opcode],bx
;	mov	bx,[opcode]
;	mov	[operand],cx

;	mov	eax,4
;	push	bx
;	mov	ebx,1
;	mov	ecx,[opcode]
;	pop	cx
;	mov	ecx, [operation]
;	mov	edx,20
;	int	80h

analyze_done:
	pop	esi
	call	end
