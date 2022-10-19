	.file	"foo2.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	get_array_size
	.type	get_array_size, @function
get_array_size:
	endbr64
	push	rbp  # пролог, часть 1 (сохраняем старое значение регистра rbp на стеке)
	mov	rbp, rsp  # пролог, часть 2 (запоминаем указатель фрейма)
	sub	rsp, 16  # сдвигаем указатель стека на 16 байт
	# mov	QWORD PTR -8[rbp], rdi  # в rdi лежит size, теперь он лежит также по адресу rbp-8
	# не используем озу, вместо этого кладем size в rsi и используем региср
	# mov	rax, QWORD PTR -8[rbp]
	mov	rax, rdi  # в rax лежит значение переменной по адресу size
	mov	rsi, rax  # в rsi кладем второй аргумент функции scanf - size
	lea	rax, .LC0[rip]  # по адресу(метке) .LC0 лежит модификатор типа - "%d"
	mov	rdi, rax  # в rdi кладем первый аргумент функции scanf - модификатор типа "%d"
	mov	eax, 0
	call	__isoc99_scanf@PLT
	nop
	leave
	ret
	.size	get_array_size, .-get_array_size
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
