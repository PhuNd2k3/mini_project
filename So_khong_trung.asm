.data
	A: .space 400
	B: .space 400
	C: .space 400
	D: .space 400
	arrMes1: .asciiz "A["
	arrMes2: .asciiz "] = "
	message1: .asciiz "Nhap so phan tu cua mang: "
	message2: .asciiz " "
	space: .asciiz " "
	error: .asciiz "ERROR: So phan tu mang phai la mot so duong. Vui long nhap lai!\n"
.text
NhapN:	li 	$v0, 4			# Thong bao nhap so phan tu mang A
	la 	$a0, message1
	syscall
	li	$v0, 5			# Nhap N
	syscall
	blez	$v0, Error		# Neu N <= 0 thi thong bao loi va nhap lai N
	add	$s0, $zero, $v0		# s0 = N
	j	NhapMang
Error:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error
	syscall
	j	NhapN			# Quay lai nhap lai N
NhapMang:
	li	$t0, -1			# Khoi tao i cho vong For1
	
For1:	addi	$t0, $t0, 1		# i = i + 1
	bge	$t0, $s0, EndFor1	# Neu i = N thi ket thuc vong For1
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
EndFor1:
main:
	li $t0,0		# i cho vong for ngoai
	li $t1,0		# j cho vong for trong
	li $t2,0		# bien dem so lan xuat hien
	li $t8,1		# dung de so sanh voi $t2
loop1:
	beq $t0,$s0,endloop1	# i=n thi ket thuc
	sll $t4,$t0,2
	add $t4,$a0,$t4
	lw $t3,0($t4)	# t3 chua dia chi A[i}
loop1_2:
	beq $t1,$s0,endloop1_2	# j=n thi ket thuc
	sll $t6,$t1,2
	add $t6,$a0,$t6	# t6 chua dia chi A[j]
	lw $t5,0($t6)
	bne $t5,$t3,continue	# neu khong bang nhau thi khong tang $t2
	addi $t2,$t2,1	# $t2=count ++
continue:
	addi $t1,$t1,1	# j++
	j loop1_2
endloop1_2:
	addi $t0,$t0,1	# i++
	beq $t2,$t8,print	# neu count =1 thi print
	li $t1,0		# tra lai gia tri de chay for
	li $t2,0
	j loop1
endloop1:
	li $v0,10
	syscall
print:
	li $v0,1
	move $a0,$t3
	syscall
	li $v0, 4
	la $a0, message2
	syscall	
	la $a0, A		# tra lai cac gia tri de chay vong for
	li $t1,0
	li $t2,0
	j loop1
