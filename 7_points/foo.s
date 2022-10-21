	.file	"foo1.c"
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
	# не используем озу, вместо этого кладем size в rsi и используем регистр
	# mov	QWORD PTR -16[rbp], rsi  # аналогично
	mov	rdx, rdi
	mov	rax, rsi
	lea	rcx, .LC0[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	nop
	leave
	ret
	.size	get_array_size, .-get_array_size
	.globl	get_array
	.type	get_array, @function
get_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r12
	push 	r13
	push	r14
	# sub 	rsp, 8
	# sub	rsp, 48
	sub	RSP, 56
	# mov	QWORD PTR -24[rbp], rdi  # по адресу rbp-24 лежит указатель на массив а, т е *а
	mov	r12, rdi  # теперь указатель на массив а лежит в r12, т е r12 = *a
	# mov	DWORD PTR -28[rbp], esi  # по адресу rbp-28 лежит аргумент size
	mov	ebx, esi  # теперь аргмент size лежит в ebx, т е ebx = size
	# mov	QWORD PTR -40[rbp], rdx
	mov	r14, rdx
	# mov	DWORD PTR -4[rbp], 0  # по адресу rbp-4 лежит лок.переменная i
	mov	r13d, 0  # теперь лок. переменная i лежит в регистре r13d
	jmp	.L3
.L4:
	mov	eax, r13d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, r12
	add	rdx, rax
	mov	rax, r14
	lea	rcx, .LC0[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	add	r13d, 1
.L3:
	mov	eax, r13d
	cmp	eax, ebx
	jl	.L4
	nop
	nop
	add	rsp, 8
	pop	r14
	pop	r13
	pop	r12
	leave
	ret
	.size	get_array, .-get_array
	.globl	create_new_arr
	.type	create_new_arr, @function
create_new_arr:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	push	r12
	push	r13
	sub	rsp, 8
	# mov	QWORD PTR -24[rbp], rdi  # rdi = a, по адресу rbp-24 лежит аргумент int* a
	# теперь а* лежит только в rdi, озу не трогаем
	# mov	QWORD PTR -32[rbp], rsi  # rsi = b, по адресу rbp-32 лежит аргумент int* b
	# теперь b* лежит только в rsi, озу не трогаем
	# mov	DWORD PTR -36[rbp], edx  # edx = size_a, по адресу rbp-36 лежит аргумент int size_a 
	# теперь size_a лежит только в edx, озу не трогаем
	mov	ebx, edx  # кладем size_a в ebx, т к в edx будет меняться в силу изменения rbx
	# mov	DWORD PTR -4[rbp], 0  # лок. переменная j, лежит по адресу rbp-4 # свободных 32биных регистров, которые не были бы затерты 64битными решистрами, не осталось, поэтому придется класть j в озу 
	mov	r12d, 0  # лок. переменная j теперь лежит в регистре r12d
	# mov	DWORD PTR -8[rbp], 1  # лок. переменная i (счетчик цикла), лежит по адресу rbp-8 # свободных 32биных регистров, которые не были бы затерты 64битными регистрами, не осталось, поэтому придется класть i в озу 
	mov	r13d, 1  # теперь лок. переменная i (счетчик цикла) лежит в регистре r13d
	jmp	.L6
.L8:
	mov	eax, r13d # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]  # смещение массива на 4*i
	mov	rax, rdi  # в rax лежит *a
	add	rax, rdx  # rax = адресс i-того элемента массива
	mov	edx, DWORD PTR [rax]  # edx = значение i-того элемента массива a
	mov	rax, rdi  # rax = адресс 0-вого элемента массива
	mov	eax, DWORD PTR [rax]  # eax = значение 0-вого элемента массива
	cmp	edx, eax  # <=> a[i] != a[0] 
	je	.L7
	mov	eax, r13d  # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]  # смещение массива на 4*i
	mov	rax, rdi  # в rax лежит *a
	add	rax, rdx  # rax = адресс i-того элемента массива
	mov	edx, DWORD PTR [rax]  # edx = значение 0-вого элемента массива
	mov	eax, ebx # eax = size_a
	cdqe
	sal	rax, 2
	lea	rcx, -4[rax]
	mov	rax, rdi
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L7
	mov	eax, r13d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	edx, r12d
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, rsi
	add	rdx, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	r12d, 1
.L7:
	add	r13d, 1
.L6:
	mov	eax, r13d
	cmp	eax, ebx
	jl	.L8
	nop
	nop
	add	rsp, 8
	pop	r13
	pop	r12
	pop	rbx
	pop	rbp
	ret
	.size	create_new_arr, .-create_new_arr
	.section	.rodata
.LC1:
	.string	"%d "
	.text
	.globl	print_array
	.type	print_array, @function
print_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	push	rbx
	push	r12
	push	r13
	push	r14
	# mov	QWORD PTR -24[rbp], rdi  # rdi = адрес массива a, который(адрес) лежит по адресу rbp-24
	mov	r13, rdi  # теперь адрес массива a лежит в регистре r13
	# mov	DWORD PTR -28[rbp], esi  # esi = переменная size, лежащая по адресу rbp-28
	mov	r12d, esi  # теперь переменная size лежит в регистре r12d, озу не трогаем
	# mov	QWORD PTR -40[rbp], rdx  # rdx = FILE* output, т е переменная output типа FILE* лежит по адресу rbp-40
	mov	r14, rdx  # теперь переменная output лежит в регистре r14, озу не трогаем
	# mov	DWORD PTR -4[rbp], 0  # лок.переменная i лежит по адресу rbp-4
	mov	ebx, 0  # теперь лок. переменная i лежит в регистре ebx
	jmp	.L10
.L11:
	mov	eax, ebx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, r13
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, r14
	lea	rcx, .LC1[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	mov	eax, ebx
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, r13
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	ebx, 1
.L10:
	mov	eax, ebx  # eax = i
	cmp	eax, r12d  # i < size ?
	jl	.L11
	nop
	nop
	pop	r14
	pop	r13
	pop	r12
	pop 	rbx
	leave
	ret
	.size	print_array, .-print_array
	.section	.rodata
	.align 8
.LC2:
	.string	"Command line must have 2 arguements - names of files input/output"
.LC3:
	.string	"r"
.LC4:
	.string	"w"
	.text
	.globl	main
	.type	main, @function
main:  # в main ф-ии изменений нет, т к в ней уже используются все регистры
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 120
	mov	DWORD PTR -116[rbp], edi
	mov	QWORD PTR -128[rbp], rsi
	mov	rax, rsp
	mov	rbx, rax
	cmp	DWORD PTR -116[rbp], 3
	je	.L13
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L14
.L13:
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -64[rbp], rax
	mov	rdx, QWORD PTR -64[rbp]
	lea	rax, -108[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	get_array_size
	mov	eax, DWORD PTR -108[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -72[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -144[rbp], rdx
	mov	QWORD PTR -136[rbp], 0
	movsx	rdx, eax
	mov	QWORD PTR -160[rbp], rdx
	mov	QWORD PTR -152[rbp], 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L15:
	cmp	rsp, rdx
	je	.L16
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L15
.L16:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L17
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L17:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -80[rbp], rax
	mov	ecx, DWORD PTR -108[rbp]
	mov	rdx, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	get_array
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	DWORD PTR -52[rbp], 0
	mov	DWORD PTR -56[rbp], 1
	jmp	.L18
.L20:
	mov	rax, QWORD PTR -80[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	edx, DWORD PTR [rax+rdx*4]
	mov	rax, QWORD PTR -80[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L19
	mov	rax, QWORD PTR -80[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	ecx, DWORD PTR [rax+rdx*4]
	mov	eax, DWORD PTR -108[rbp]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -80[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	cmp	ecx, eax
	je	.L19
	add	DWORD PTR -52[rbp], 1
.L19:
	add	DWORD PTR -56[rbp], 1
.L18:
	mov	eax, DWORD PTR -108[rbp]
	sub	eax, 1
	cmp	DWORD PTR -56[rbp], eax
	jl	.L20
	mov	eax, DWORD PTR -52[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -88[rbp], rdx
	movsx	rdx, eax
	mov	r14, rdx
	mov	r15d, 0
	movsx	rdx, eax
	mov	r12, rdx
	mov	r13d, 0
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	eax, 16
	sub	rax, 1
	add	rax, rdx
	mov	esi, 16
	mov	edx, 0
	div	rsi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L21:
	cmp	rsp, rdx
	je	.L22
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L21
.L22:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L23
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L23:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -96[rbp], rax
	mov	edx, DWORD PTR -108[rbp]
	mov	rcx, QWORD PTR -96[rbp]
	mov	rax, QWORD PTR -80[rbp]
	mov	rsi, rcx
	mov	rdi, rax
	call	create_new_arr
	mov	rax, QWORD PTR -128[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -104[rbp], rax
	mov	rdx, QWORD PTR -104[rbp]
	mov	ecx, DWORD PTR -52[rbp]
	mov	rax, QWORD PTR -96[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
	mov	rax, QWORD PTR -104[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
.L14:
	mov	rsp, rbx
	lea	rsp, -40[rbp]
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
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
