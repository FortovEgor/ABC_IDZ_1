# COMMENTS!!!!
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
	mov	QWORD PTR -8[rbp], rdi  # в rdi лежит size, теперь он лежит также по адресу rbp-8
	mov	rax, QWORD PTR -8[rbp]  # в rax лежит значение переменной по адресу size
	mov	rsi, rax  # в rsi кладем второй аргумент функции scanf - size
	lea	rax, .LC0[rip]  # по адресу(метке) .LC0 лежит модификатор типа - "%d"
	mov	rdi, rax  # в rdi кладем первый аргумент функции scanf - модификатор типа "%d"
	mov	eax, 0  # возвращаемое значение функции (хотя функция иммет тип возвращ.значения void)
	call	__isoc99_scanf@PLT
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
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi  # по адресу rbp-24 лежит указатель на массив а, т е *а
	mov	DWORD PTR -28[rbp], esi  # по адресу rbp-28 лежит аргумент size
	mov	DWORD PTR -4[rbp], 0  # по адресу rbp-4 лежит лок.переменная i
	jmp	.L3
.L4:
	mov	eax, DWORD PTR -4[rbp]  # теперь i лежит также в eax
	cdqe
	lea	rdx, 0[0+rax*4]  # в rdx лежит смещение относительно массива, т е i*4 (т к массив 4байтных элементов)
	mov	rax, QWORD PTR -24[rbp]  # в rax лежит *a
	add	rax, rdx  # прибавляем к адресу первого элемента массива смещение, чтобы получить адрес i-ого элемента
	mov	rsi, rax  # в rsi лежит второй аргумент - адрес i-ого элемента массива а
	lea	rax, .LC0[rip]  # по адресу(метке) .LC0 лежит модификатор типа - "%d"
	mov	rdi, rax  # в rdi лежит форматная строка -  "%d"
	mov	eax, 0  # возвращаемое значение функции
	call	__isoc99_scanf@PLT
	add	DWORD PTR -4[rbp], 1  # <=> ++i
.L3:
	mov	eax, DWORD PTR -4[rbp]  # в eax лежит i
	cmp	eax, DWORD PTR -28[rbp]  # <=> i < size
	jl	.L4 <=> возвращаемся в цикл, если условие выше выполнено
	nop
	nop
	leave
	ret
	.size	get_array, .-get_array
	.globl	create_new_arr
	.type	create_new_arr, @function
create_new_arr:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -24[rbp], rdi  # rdi = a, по адресу rbp-24 лежит аргумент int* a
	mov	QWORD PTR -32[rbp], rsi  # rsi = b, по адресу rbp-32 лежит аргумент int* b
	mov	DWORD PTR -36[rbp], edx  # edx = size_a, по адресу rbp-36 лежит аргумент int size_a 
	mov	DWORD PTR -4[rbp], 0  # лок. переменная j, лежит по адресу rbp-4
	mov	DWORD PTR -8[rbp], 1  # лок. переменная i (счетчик цикла), лежит по адресу rbp-8
	jmp	.L6
.L8:
	mov	eax, DWORD PTR -8[rbp]  # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]  # смещение массива на 4*i
	mov	rax, QWORD PTR -24[rbp]  # в rax лежит *a
	add	rax, rdx  # rax = адресс i-того элемента массива
	mov	edx, DWORD PTR [rax]  # edx = значение i-того элемента массива a
	mov	rax, QWORD PTR -24[rbp]  # rax = адресс 0-вого элемента массива
	mov	eax, DWORD PTR [rax]  # eax = значение 0-вого элемента массива
	cmp	edx, eax  # <=> a[i] != a[0] 
	je	.L7
	mov	eax, DWORD PTR -8[rbp]  # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]  # смещение массива на 4*i
	mov	rax, QWORD PTR -24[rbp]  # в rax лежит *a
	add	rax, rdx  # rax = адресс i-того элемента массива
	mov	edx, DWORD PTR [rax]  # edx = значение 0-вого элемента массива
	mov	eax, DWORD PTR -36[rbp]  # eax = size_a
	cdqe
	sal	rax, 2
	lea	rcx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L7
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR -4[rbp], 1
.L7:
	add	DWORD PTR -8[rbp], 1
.L6:
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L8
	nop
	nop
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
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi  # rdi = адрес массива a, который(адрес) лежит по адресу rbp-24
	mov	DWORD PTR -28[rbp], esi  # esi = переменная size, лежащая по адресу rbp-28
	mov	DWORD PTR -4[rbp], 0  # лок.переменная i лежит по адресу rbp-4
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -4[rbp]  # в eax теперь лежит i
	cdqe
	lea	rdx, 0[0+rax*4]  # смещение
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx  # добавляем смещение к адресу массива
	mov	eax, DWORD PTR [rax] 
	mov	esi, eax  # второй аргумент функции - a[i]
	lea	rax, .LC1[rip]  # по адресу (метке) .LC1 лежит форматная строка "%d", теперь она лежит в rax
	mov	rdi, rax  # rdi = rax = .LC1
	mov	eax, 0  # возвращаемое значение функции
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L10:
	mov	eax, DWORD PTR -4[rbp]  # eax = i
	cmp	eax, DWORD PTR -28[rbp]  # i < size ?
	jl	.L11
	nop
	nop
	leave
	ret
	.size	print_array, .-print_array
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 104
	mov	DWORD PTR -100[rbp], edi
	mov	QWORD PTR -112[rbp], rsi
	mov	rax, rsp 
	mov	rbx, rax
	lea	rax, -92[rbp]  # по адресу rbp-92 лежит лок.переменная n
	mov	rdi, rax  # rdi = &n
	call	get_array_size
	mov	eax, DWORD PTR -92[rbp]  # eax = n
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -64[rbp], rdx
	movsx	rdx, eax
	mov	QWORD PTR -128[rbp], rdx
	mov	QWORD PTR -120[rbp], 0
	movsx	rdx, eax
	mov	QWORD PTR -144[rbp], rdx
	mov	QWORD PTR -136[rbp], 0
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
.L13:
	cmp	rsp, rdx
	je	.L14
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L13
.L14:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L15
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L15:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -72[rbp], rax
	mov	edx, DWORD PTR -92[rbp]  # по адресу rbp-92 лежит n
	mov	rax, QWORD PTR -72[rbp]  # rbp-72 - адрес 0-ого эл-та массива, т е массив а лежит по этому адресу
	mov	esi, edx  # esi = n - 2-ой аргумент
	mov	rdi, rax  # в rdi лежит ссылка на 0-ой элемент массива a - 1-ый аргумент функции ниже
	call	get_array
	mov	DWORD PTR -52[rbp], 0  # по адресу rbp-52 лежит лок.переменная needed_arguements_quality = 0
	mov	DWORD PTR -56[rbp], 1  # по адресу rbp-56 лежит лок. переменная i = 1 (счетчик в цикле)
	jmp	.L16
.L18:
	mov	rax, QWORD PTR -72[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	edx, DWORD PTR [rax+rdx*4]
	mov	rax, QWORD PTR -72[rbp]
	mov	eax, DWORD PTR [rax]
	cmp	edx, eax
	je	.L17
	mov	rax, QWORD PTR -72[rbp]
	mov	edx, DWORD PTR -56[rbp]
	movsx	rdx, edx
	mov	ecx, DWORD PTR [rax+rdx*4]
	mov	eax, DWORD PTR -92[rbp]
	lea	edx, -1[rax]
	mov	rax, QWORD PTR -72[rbp]
	movsx	rdx, edx
	mov	eax, DWORD PTR [rax+rdx*4]
	cmp	ecx, eax
	je	.L17
	add	DWORD PTR -52[rbp], 1
.L17:
	add	DWORD PTR -56[rbp], 1
.L16:
	mov	eax, DWORD PTR -92[rbp]
	sub	eax, 1
	cmp	DWORD PTR -56[rbp], eax
	jl	.L18
	mov	eax, DWORD PTR -52[rbp]
	movsx	rdx, eax
	sub	rdx, 1
	mov	QWORD PTR -80[rbp], rdx
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
	mov	edi, 16
	mov	edx, 0
	div	rdi
	imul	rax, rax, 16
	mov	rcx, rax
	and	rcx, -4096
	mov	rdx, rsp
	sub	rdx, rcx
.L19:
	cmp	rsp, rdx
	je	.L20
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L19
.L20:
	mov	rdx, rax
	and	edx, 4095
	sub	rsp, rdx
	mov	rdx, rax
	and	edx, 4095
	test	rdx, rdx
	je	.L21
	and	eax, 4095
	sub	rax, 8
	add	rax, rsp
	or	QWORD PTR [rax], 0
.L21:
	mov	rax, rsp
	add	rax, 3
	shr	rax, 2
	sal	rax, 2
	mov	QWORD PTR -88[rbp], rax
	mov	edx, DWORD PTR -92[rbp]  # edx = n
	mov	rcx, QWORD PTR -88[rbp]  # т е указатель на массив b лежит по адресу rbp-88
	mov	rax, QWORD PTR -72[rbp]  # т е указатель на массив a лежит по адресу rbp-72
	mov	rsi, rcx  # rsi = b
	mov	rdi, rax  # rdi = a
	call	create_new_arr
	mov	edx, DWORD PTR -52[rbp]   # по адресу rbp-52 по-прежнему лежит лок.переменная needed_arguements_quality
	mov	rax, QWORD PTR -88[rbp]  # # т е указатель на массив b по-прежнему лежит по адресу rbp-88
	mov	esi, edx  # esi = needed_arguements_quality
	mov	rdi, rax  # rdi = b
	call	print_array
	mov	eax, 0
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
