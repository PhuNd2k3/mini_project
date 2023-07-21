.data
	A: .space 400
	B: .space 400
	C: .space 400
	D: .space 400
	arrMes1: .asciiz "A["
	arrMes2: .asciiz "] = "
	message1: .asciiz "Nhap so phan tu cua mang: "
	message2: .asciiz "Nhap so k: "
	message3: .asciiz ""
	message4: .asciiz ""
	space: .asciiz " "
	error: .asciiz "ERROR: So phan tu mang phai la mot so duong. Vui long nhap lai!\n"
	error2: .asciiz "ERROR: So k phai la mot so duong va nho hon N. Vui long nhap lai!\n"
.text
NhapN:	li 	$v0, 4			# Thong bao nhap so phan tu mang A
	la 	$a0, message1
	syscall
	li	$v0, 5			# Nhap N
	syscall
	blez	$v0, Error			# Neu N <= 0 thi thong bao loi va nhap lai N
	add	$s0, $zero, $v0	# s0 = N so phan tu cua mang
	j	Nhapk
Error:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error
	syscall
	j	NhapN			# Quay lai nhap lai N
	
Nhapk:	li 	$v0, 4			# Thong bao nhap k
	la 	$a0, message2
	syscall
	li	$v0, 5			# Nhap k
	syscall
	blez	$v0, Error2			# Neu k <= 0 thi thong bao loi va nhap lai k
	sgt	$v1, $v0, $s0
	bne 	$v1, $0, Error2		# neu k>N thi nhap lai
	add	$s1, $zero, $v0	# s1 = k

	j	NhapMang
Error2:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error2
	syscall
	j	Nhapk			# Quay lai nhap lai N	

NhapMang:
	li	$t0, -1			# Khoi tao i cho vong For1
	
For1:	addi	$t0, $t0, 1			# i = i + 1
	bge	$t0, $s0, EndFor1		# Neu i = N thi ket thuc vong For1
	# Thong bao nhap tung phan tu cua mang
	#		A[i] = 
	li 	$v0, 4
	la 	$a0, arrMes1
	syscall
	li	$v0, 1			
	add	$a0, $zero, $t0
	syscall
	li 	$v0, 4
	la 	$a0, arrMes2
	syscall
	
	li	$v0, 5			# Nhap gia tri phan tu
	syscall
	la	$a0, A			# Ghi gia tri vua nhap vao phan tu A[i]
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	sw	$v0, 0($t1)
	j	For1			# Tiep tuc vong lap
EndFor1:					# a0 dang luu dia chi A

main: 
	addi 	$t0, $s1, -1	#do chi so bat dau tu 0
	sll 	$t1, $t0,2		
	add 	$t1, $a0, $t1	# A[k]
	beq 	$t0,$0,endloop	#Truong hop mang chi co 1 phan tu
loop:	#chay vong for tu vi tri k, bien chay i la $t0
	beq 	$t0,$s0, endloop
	lw 	$t3, 4($t1)		#A[i+1]
	sw 	$t3, 0($t1)		#A[i]=A[i+1]
	add	 $t0,$t0,1
	sll 	$t1, $t0, 2
	add 	$t1, $t1, $a0	# t1 chua dia chi A[i+1]
	j loop
endloop:	
	sw $0, 0($t1) 		#xoa phan tu cuoi