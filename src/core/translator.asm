SECTION .data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;		opcodes			;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
op_plus		db	"00001"
op_sub		db	"00010"
op_div		db	"00011"
op_mul		db	"00100"

debug		db	"success"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;		operands		;;
;;	--------------------------	;;
;;	      (baudot code)		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SECTION .text

translate_opcode:
	push	eax
	push	ebx
	push	ecx
	push	edx
	mov	ecx, opcode
	mov	eax, 4
	mov	ebx, 1
;	mov	ecx, [opcode]
	mov	edx, 5
	int	80h
	pop	edx
	pop	ecx
	pop	ebx
	pop	eax
	mov	edx, [opcode]
	cmp	edx, [op_plus]
	je	eop_plus
	cmp	edx, [op_sub]
	je	eop_sub
	cmp	edx, [op_div]
	je	eop_div
	cmp	edx, [op_mul]
	je	eop_mul
	jmp	error
translate_operand:


eop_plus:						; execute operation plus
	mov	eax,4
	mov	ebx,1
	mov	ecx,op_plus
	mov	edx,5
	int	80h
eop_sub:
	mov	eax,4
	mov	ebx,1
	mov	ecx,op_sub
	mov	edx,5
	int	80h
eop_div:
	mov	eax,4
	mov	ebx,1
	mov	ecx,op_div
	mov	edx,5
	int	80h
eop_mul:
        mov     eax, 4
        mov     ebx, 1
        mov     ecx, debug
        mov     edx, 7
        int     80h
	jmp 	error

        mov     eax, 1
        xor     ebx,ebx
        int     80h
	ret
;	jmp	analyze_done

error:
	mov	eax, 4
	mov	ebx, 2
	mov	ecx, errmsg
	mov	edx, errmsg_len
	int	80h
	jmp	end
