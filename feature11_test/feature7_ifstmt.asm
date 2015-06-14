%include "libasm.h"
	SECTION .text
	GLOBAL main
main:
	push ebp
	mov ebp, esp
	sub esp, 4
	jo STKOV
	jmp L1
	pushad
	mov eax, 10
	push eax
	call wint
	pop eax
	popad
	call wln
	jmp L2
L1:
	mov eax, 99
	mov ebx, ebp
	times 0 mov ebx, [ebx]
	mov [ebx + -4], eax
L2:
	mov eax, ebp
	times 0 mov eax, [eax]
	mov eax, [eax + -4]
	pushad
	push eax
	call wint
	pop eax
	popad
	call wln
	mov esp, ebp
	pop ebp
	mov eax, 0
	ret
BADRNG:
	mov edx, badrngstr
	jmp failure
BADDIV:
	mov edx, baddivstr
	jmp failure
BADCAS:
	mov edx, badcasstr
	jmp failure
BADPTR:
	mov edx, badptrstr
	jmp failure
BADSUB:
	mov edx, badsubstr
	jmp failure
STKOV:
	mov edx, stkovstr
	jmp failure
HEAPOV:
	mov edx, heapovstr
	jmp failure
failure:
	call WriteString
	mov ebx, 1
	call Exit
wstr:
	push ebp
	mov ebp, esp
	mov edx, [ebp + 8]
	call WriteString
	mov esp, ebp
	pop ebp
	ret
wint:
	push ebp
	mov ebp, esp
	mov eax, [ebp + 8]
	call WriteInt
	mov esp, ebp
	pop ebp
	ret
wln:
	push ebp
	mov ebp, esp
	push edx
	mov edx, nlstr
	call WriteString
	pop edx
	mov esp, ebp
	pop ebp
	ret
copy:
	push ebp
	mov ebp, esp
	mov esi, [ebp + 8]
	mov edi, [ebp +12]
	cld
	mov ecx, [ebp +16]
	rep movsb
	mov esp, ebp
	pop ebp
	ret
alloc:
	push ebp
	mov ebp, esp
	mov eax, [heapptr]
	add eax, [ebp + 8]
	cmp eax, heapsz
	ja HEAPOV
	mov [heapptr], eax
	sub eax, [ebp + 8]
	mov esp, ebp
	pop ebp
	ret
	SECTION .data
nlstr:     db 0x0A, 0
badrngstr: db 0x0A, "Value out of range in assignment", 0x0A, 0
baddivstr: db 0x0A, "Division by zero",0x0A, 0
badcasstr: db 0x0A, "Value not handled in case statement", 0x0A, 0
badptrstr: db 0x0A, "Attempt to use a null pointer", 0x0A, 0
badsubstr: db 0x0A, "Subscript out of bounds", 0x0A, 0
stkovstr:  db 0x0A, "Stack overflow", 0x0A, 0
heapovstr: db 0x0A, "Out of heap space", 0x0A, 0
	SECTION .bss
align 2
heap:      resb 8192
heapsz:    equ $-heap
	SECTION .data
heapptr:   dd heap
