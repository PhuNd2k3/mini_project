#Nguyen Duc Phu
#Bai tap B_11
.data
	A: .word 400
	arrMes1: .asciiz "A["
	arrMes2: .asciiz "] = "
	message1: .asciiz "Nhap so phan tu cua mang: "
	message2: .asciiz "Nhap so k: "
	message3: .asciiz "Nhap lan luot cac phan tu:\n"
	message4: .asciiz "Mang sau khi xoa la:\n"
	message5: .asciiz "Mang khong con phan tu nao sau khi xoa\n"
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
	add	$s0, $zero, $v0		# s0 = N so phan tu cua mang
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
	add	$s1, $zero, $v0		# s1 = k

	j	NhapMang
Error2:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error2
	syscall
	j	Nhapk			# Quay lai nhap lai N	

NhapMang:
	li	$t0, -1			# Khoi tao i cho vong For1
	# Thong bao nhap tung phan tu cua mang
	li 	$v0, 4
	la 	$a0, message3
	syscall
For1:	addi	$t0, $t0, 1			# i = i + 1
	bge	$t0, $s0, EndFor1		# Neu i = N thi ket thuc vong For1
	li	$v0, 5			# Nhap gia tri phan tu
	syscall
	la	$a0, A			# Ghi gia tri vua nhap vao phan tu A[i]
	sll	$t1, $t0, 2
	add	$t1, $t1, $a0
	sw	$v0, 0($t1)
	j	For1			# Tiep tuc vong lap
EndFor1:					# a0 dang luu dia chi A

main: 
	addi 	$t0, $s1, -1	#Bat dau duyet tu A[k-1}
	sll 	$t1, $t0,2		
	add 	$t1, $a0, $t1	#Dia chi phan tu vi tri k: A[k-1]
	li 	$v0, 1
	beq 	$s0, $v0, mot_ptu	#Truong hop mang chi co 1 phan tu
loop:	#chay vong for tu vi tri k, bien chay i la $t0
	beq 	$t0,$s0, endloop
	lw 	$t3, 4($t1)		#A[i+1]
	sw 	$t3, 0($t1)		#A[i]=A[i+1]
	add	$t0,$t0,1		#i++
	sll 	$t1, $t0, 2		#$t1=4*$t0
	add 	$t1, $t1, $a0	# t1 chua dia chi A[i+1]
	j loop

endloop:	
	sw $0, -4($t1) 		#xoa phan tu cuoi
continue:
	li $v0, 4			# Thong bao ket qua
	la $a0, message4
	syscall
	la $t6, A			# Bien dia chi de in mang
	sll $t7,$s0,2		# $t7=4*N
	addi $t7, $t7,-4		# Do da xoa 1 phan tu		
	add $t7,$t7,$t6		# Dia chi A_end			
	j show_arr
Exit:
	li $v0,10
	syscall
mot_ptu:
	sw $0, 0($t1) 		#xoa chinh so vua nhap
	li $v0, 4
	la $a0,message5
	syscall
	j Exit
show_arr:
	li $v0,1
	lw $a0,0($t6)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $t6,$t6,4
	bne $t6,$t7,show_arr
	j Exit
