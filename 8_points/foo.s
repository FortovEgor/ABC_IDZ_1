	.file	"foo.c"
	.intel_syntax noprefix
	.text
	.globl	THRESHOLD
	.section	.rodata
	.align 4
	.type	THRESHOLD, @object
	.size	THRESHOLD, 4
THRESHOLD:
	.long	2147483637
.LC0:
	.string	"%d"
	.text
	.globl	get_array_size
	.type	get_array_size, @function
get_array_size:
	# endbr64 - макрос "безопасности"
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
	# endbr64 - макрос "безопасности"
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
get_random_array:
	# endbr64 - макрос "безопасности"
	push	rbp
	mov	rbp, rsp
	push	r12
	push	r13
	push	r14
	# sub	rsp, 8
	# sub	rsp, 32
	sub	rsp, 40
	# mov	QWORD PTR -24[rbp], rdi  # rdi = a, т е в регистре rdi лежит аргумент int* a
	mov	r12, rdi
	# mov	DWORD PTR -28[rbp], esi  # esi = size, т е в регистре esi лежит аргумент int size
	mov	r13d, esi
	# mov	DWORD PTR -4[rbp], 0
	mov	r14d, 0  # r14d = i (счетчик цикла)
	jmp	.L6
.L7:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	sar	edx, 5
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	ecx, edx, 100
	sub	eax, ecx
	mov	edx, eax
	mov	eax, r14d
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, r12
	add	rax, rcx
	sub	edx, 50
	mov	DWORD PTR [rax], edx
	add	r14d, 1
.L6:
	mov	eax, r14d
	cmp	eax, r13d
	jl	.L7
	nop
	nop
	add	rsp, 8
	pop	r14
	pop	r13
	pop	r12
	leave
	ret
	.size	get_random_array, .-get_random_array
	.globl	create_new_arr
	.type	create_new_arr, @function
create_new_arr:
	# endbr64 - макрос "безопасности"
	push	rbp
	mov	rbp, rsp
	push	r12
	push	r13
	# mov	QWORD PTR -24[rbp], rdi  # rdi = int* a
	# mov	QWORD PTR -32[rbp], rsi  # rsi = int* b
	# mov	DWORD PTR -36[rbp], edx  # edx = int size_a
	# mov	DWORD PTR -4[rbp], 0
	mov	r12d, 0  # r12d = int j; j = 0
	# mov	DWORD PTR -8[rbp], 1
	mov	r13d, 1  # r13d = int i; i = 1
	jmp	.L9
.L11:
	mov	eax, r13d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, rdi
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L10
	mov	eax, r13d
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, rdi
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, edx
	cdqe
	sal	rax, 2
	lea	rcx, -4[rax]
	mov	rax, rdi
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L10
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
	add	r12d, 1  # ++j
.L10:
	add	r13d, 1
.L9:
	mov	eax, r13d
	cmp	eax, edx
	jl	.L11
	nop
	nop
	pop	r13
	pop	r12
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
	# endbr64 - макрос "безопасности"
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
	jmp	.L13
.L14:
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
.L13:
	mov	eax, ebx  # eax = i
	cmp	eax, r12d  # i < size ?
	jl	.L14
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
	.string	"Command line must have 3 arguements - names of files input/output & seed for generator "
.LC3:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"TIME: %f sec"
	.text
	.globl	main
	.type	main, @function
main:
	# endbr64 - макрос "безопасности"
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 168
	mov	DWORD PTR -164[rbp], edi  # edi = argc
	mov	QWORD PTR -176[rbp], rsi  # rsi = argv
	mov	rax, rsp
	mov	rbx, rax
	cmp	DWORD PTR -164[rbp], 4
	je	.L16
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 1
	jmp	.L17
.L16:
	mov	rax, QWORD PTR -176[rbp]  # по адресу rbp-176 лежат строки cmd, т е argv
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -68[rbp], eax  # по адресу rbp-48 лежит лок. переменная seed
	mov	eax, DWORD PTR -68[rbp]
	mov	edi, eax  # seed лежит в edi (регистр для первого аргумента функции srand)
	call	srand@PLT
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC3[rip]
	mov	rsi, rdx  # в rsi лежит форматная строка "r" (открытие файла на чтение)
	mov	rdi, rax  # в rdi лежит 1-ый (не нулевой) элемент массива argv, т е название входного файла (input.txt)
	call	fopen@PLT
	# rax = input после отработки функции fopen
	mov	QWORD PTR -80[rbp], rax
	mov	rdx, QWORD PTR -80[rbp]
	lea	rax, -148[rbp]  # по адресу rbp-148 лежит лок. переменная n
	mov	rsi, rdx
	mov	rdi, rax
	call	get_array_size
	mov	eax, DWORD PTR -148[rbp]  # по адресу rbp-148 лежит лок. переменная n
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -88[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -192[rbp], rdx
	mov	QWORD PTR -184[rbp], 0
	movsx	rdx, eax
	mov	QWORD PTR -208[rbp], rdx
	mov	QWORD PTR -200[rbp], 0
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
.L18:
	cmp	rsp, rdx
	je	.L19
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L18
.L19:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L20
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L20:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -96[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	mov	rdi, rax  # в rdi лежит input
	call	fclose@PLT
	call	clock@PLT  # вызов функции clock() без параметров
	mov	QWORD PTR -104[rbp], rax  # по адресу rbp-104 лежит t
	mov	edx, DWORD PTR -148[rbp]  # edx = n
	mov	rax, QWORD PTR -96[rbp]  # rax = a
	mov	esi, edx  # esi = n
	mov	rdi, rax  # rdi = a
	call	get_random_array
	mov	DWORD PTR -52[rbp], 0  # по адресу rbp-52 лежит лок. переменная needed_arguements_quality = 0
	mov	DWORD PTR -56[rbp], 1  # по адресу rbp-56 лежит лок. переменная i = 1
	jmp	.L21
.L23:
	mov	rax, QWORD PTR -96[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	edx, DWORD PTR [rax+rdx*4]
	mov	rax, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L22
	mov	rax, QWORD PTR -96[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	ecx, DWORD PTR [rax+rdx*4]
	mov	eax, DWORD PTR -148[rbp]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -96[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	cmp	ecx, eax
	je	.L22
	add	DWORD PTR -52[rbp], 1
.L22:
	add	DWORD PTR -56[rbp], 1
.L21:
	mov	eax, DWORD PTR -148[rbp]
	sub	eax, 1
	cmp	DWORD PTR -56[rbp], eax
	jl	.L23
	mov	DWORD PTR -108[rbp], 300000000  # по адресу rbp-108 лежит лок. константа quantity_of_cycles
	mov	DWORD PTR -60[rbp], 0  # по адресу rbp-60 лежит лок. переменная j = 0
	jmp	.L24
.L28:
	mov	DWORD PTR -52[rbp], 0  # обнуляем лок. переменную needed_arguements_quality
	mov	DWORD PTR -64[rbp], 1  # по лок. адресу rbp-64 лежит лок. переменная i (счетчик внутреннего цикла)
	jmp	.L25
.L27:
	mov	rax, QWORD PTR -96[rbp]
	mov	edx, DWORD PTR -64[rbp]
	movsx	rdx, edx
	mov	edx, DWORD PTR [rax+rdx*4]
	mov	rax, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L26
	mov	rax, QWORD PTR -96[rbp]
	mov	edx, DWORD PTR -64[rbp]
	movsx	rdx, edx
	mov	ecx, DWORD PTR [rax+rdx*4]
	mov	eax, DWORD PTR -148[rbp]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -96[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	cmp	ecx, eax
	je	.L26
	add	DWORD PTR -52[rbp], 1
.L26:
	add	DWORD PTR -64[rbp], 1
.L25:
	mov	eax, DWORD PTR -148[rbp]
	sub	eax, 1
	cmp	DWORD PTR -64[rbp], eax
	jl	.L27
	add	DWORD PTR -60[rbp], 1
.L24:
	mov	eax, DWORD PTR -60[rbp]
	cmp	eax, DWORD PTR -108[rbp]
	jl	.L28
	mov	eax, DWORD PTR -52[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -120[rbp], rdx
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
.L29:
	cmp	rsp, rdx
	je	.L30
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L29
.L30:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L31
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L31:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -128[rbp], rax
	mov	edx, DWORD PTR -148[rbp]  # n
	mov	rcx, QWORD PTR -128[rbp]  # адреса массива b лежит по адресу rbp-128
	mov	rax, QWORD PTR -96[rbp]  # адреса массива b лежит по адресу rbp-96
	mov	rsi, rcx  # rsi = rcx = b
	mov	rdi, rax  # rdi = rax = a
	call	create_new_arr
	call	clock@PLT  # t = clock()  
	sub	rax, QWORD PTR -104[rbp]  # t = clock() - t
	mov	QWORD PTR -104[rbp], rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, QWORD PTR -104[rbp]  # xmm0 = (double) t
	movsd	xmm1, QWORD PTR .LC4[rip]  # xmm1 = CLOCKS_PER_SEC
	divsd	xmm0, xmm1  # xmm0 = time_taken = ((double) t)/ CLOCKS_PER_SEC;
	movsd	QWORD PTR -136[rbp], xmm0
	mov	rax, QWORD PTR -176[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]  # по метке .LC5 лежит форматная строка "w" (открываем запись на запись)
	mov	rsi, rdx
	mov	rdi, rax  # rdi = argv[2] = "output.txt" (при корректном вводе пользователем)
	call	fopen@PLT
	mov	QWORD PTR -144[rbp], rax
	mov	rdx, QWORD PTR -144[rbp]  # по адресу rbp-144 лежит output
	mov	ecx, DWORD PTR -52[rbp]  # по адресу rbp-52 лежит лок. переменная needed_arguements_quality
	mov	rax, QWORD PTR -128[rbp]  # rax = адрес массива a
	mov	esi, ecx
	mov	rdi, rax
	call	print_array
	mov	rax, QWORD PTR -144[rbp]  # по адресу rbp-144 лежит output
	mov	rdi, rax
	call	fclose@PLT
	mov	rax, QWORD PTR -136[rbp]  # по адресу rbp-136 лежит лок.переменная time_taken
	movq	xmm0, rax
	lea	rax, .LC6[rip]  # метка .LC6 соотвествует строке "TIME: %f sec"
	mov	rdi, rax  # в rdi лежит time_taken
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L17:
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
	.section	.rodata
	.align 8
.LC4:
	.long	0
	.long	1093567616
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
