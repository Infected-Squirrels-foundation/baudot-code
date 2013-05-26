sys_exit        equ     1
sys_read        equ     3
sys_write       equ     4
sys_open		equ		5
sys_close		equ		6
sys_brk			equ		45
sys_newstat		equ		106

O_RDONLY		equ		0
O_WRONLY		equ		1
O_RDWR			equ		2

stdin           equ     0
stdout          equ     1
stderr          equ     2

struc STAT        
    .st_dev:        resd 1       
    .st_ino:        resd 1    
    .st_mode:       resw 1    
    .st_nlink:      resw 1    
    .st_uid:        resw 1    
    .st_gid:        resw 1    
    .st_rdev:       resd 1        
    .st_size:       resd 1    
    .st_blksize:    resd 1    
    .st_blocks:     resd 1    
    .st_atime:      resd 1    
    .st_atime_nsec: resd 1    
    .st_mtime:      resd 1    
    .st_mtime_nsec: resd 1
    .st_ctime:      resd 1    
    .st_ctime_nsec: resd 1    
    .unused4:       resd 1    
    .unused5:       resd 1    
endstruc

%define sizeof(x) x %+ _size

SECTION     .data
szFile    	db      "TEST", 0
File_Len    equ     $-szFile


SECTION     .bss
stat		resb	sizeof(STAT)
Org_Break   resd    1
TempBuf		resd	1

SECTION     .text
global      _start
    
_start:
	;~ Get file size
	mov		ebx, szFile
	mov		ecx, stat
	mov		eax, sys_newstat
	int		80H

	;~ Get end of bss section
	xor		ebx, ebx
	mov		eax, sys_brk
	int		80H
	mov		[Org_Break], eax
	mov		[TempBuf], eax
	push	eax
	
	; extend it by file size
	pop		ebx
	add		ebx, dword [stat + STAT.st_size]
	mov		eax, sys_brk
	int		80H
	
	;~ open file
	mov		ebx, szFile
	mov		ecx, O_RDONLY
	xor		edx, edx
	mov		eax, sys_open
	int		80H
    xchg    eax, esi
	
	;~ read in file to buffer
	mov     ebx, esi
	mov		ecx, [TempBuf]
	mov		edx, dword [stat + STAT.st_size]
	mov		eax, sys_read
	int		80H

	;~ display to terminal
	mov		ebx, stdout
	mov		ecx, [TempBuf]
	mov		edx, eax
	mov		eax, sys_write
	int		80H
	
	;~ close file
	mov		ebx, esi 
	mov		eax, sys_close
	int		80H

	;~ "free" memory
	mov     ebx, [Org_Break]
    mov     eax, sys_brk
    int     80H
   	
Exit:  
    mov     eax, sys_exit
    xor     ebx, ebx
    int     80H


