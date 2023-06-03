#Nguyen Duc Phu
#Bai tap A_2
.data 
	message2: .asciiz "Nhap so nguyen duong N: "
	error: .asciiz "ERROR: Yeu cau nhap N la mot so nguyen duong. Vui long nhap lai!\n"
	message3: .asciiz "Day Fibonaci nho hon N la:\n"
	message4: .asciiz " "
.text
NhapN:  
	li 	$v0, 4			# Thong bao nhap N
	la 	$a0, message2
	syscall
	li	$v0, 5			# Nhap N
	syscall
	blez	$v0, Error			# Neu N <= 0 thi thong bao loi
	add	$t0, $zero, $v0		# $t0 = N
	j 	main
Error:	li 	$v0, 4			# Thong bao loi
	la 	$a0, error
	syscall
	j	NhapN			# Quay lai nhap lai N
main:
	li $s0,1 	#so dau tien F0
	li $s1,1 	#so thu hai F1	
	li 	$v0, 4			# Thong bao Ket qua
	la 	$a0, message3
	syscall
loop: 
	slt $t1,$s1, $t0			# neu so thu 2 lon hon N thi dung
	beq $t1,$zero,endloop		
	li $v0, 1
	move $a0,$s0			
	syscall		#In ra so thu nhat
	li $v0, 4
	la $a0, message4
	syscall		#In ra dau cach
	add $s3, $s0, $s1	#Cong hai so de tim so tiep theo
	move $s0,$s1	#Chuyen so thu 2 thanh so thu nhat
	move $s1,$s3	#Chuyen so vua cong duoc thanh so thu 2
	j loop
endloop:
	li $v0, 1		#In ra so thu nhat o vong lap cuoi
	move $a0,$s0
	syscall	
Exit:
	li $v0,10
	syscall