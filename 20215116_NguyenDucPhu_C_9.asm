#Nguyen Duc Phu
#Bai tap C_9
.data
	string: .space 500
	message1: .asciiz "Nhap xau ky tu: "
	error: .asciiz "ERROR: Khong duoc de trong. Vui long nhap lai\n"
	message2: .asciiz "Xau chuan hoa la:\n"
	comma: .asciiz ", "
	sqm: .asciiz "'"
.text
	li	$t1, 0			# Khoi tao check = 0
NhapXau:	
	li	$v0, 4			# Thong bao nhap xau
	la	$a0, message1
	syscall
	li	$v0, 8			# Nhap xau
	la	$a0, string
	li	$a1, 500
	syscall
	li	$t0, 0			# Khoi tao i cho Length
Length:	la	$a0, string
	add	$t2, $t0, $a0
	lb	$t2, 0($t2)		# Lay ra string[i] = $t2
	beq	$t2, 10, Check	# Kiem tra neu string[i] ='\n' thi ket thuc Length
	addi	$t0, $t0, 1 		# i++
	j	Length
Check: 	bne 	$t0, $0, EndLength		# $t0 khac khong thi khong loi
	li	$v0, 4			# Thong bao loi
	la	$a0, error
	syscall	
	j NhapXau
EndLength: 			# t0= do dai xau, $a0 van luu dia chi string

main:
	li $t1,0 		# Bien chay i
	li $t2, 65		# Ma ascii cua A
	li $t3, 90		# Ma ascii cua Z
	li $t4, 97		# Ma ascii cua a
	li $t5, 122		# Ma ascii cua z
	li $t6, 32		# Ma ascii cua dau cach
	li $t8, -1 		# Bien chay luu lai i-1
	
	# Lan chay dau tien
	lb $t9, 0($a0)
	sge $s0, $t9, $t4	# t9 >= 97?
	sle $s1, $t9, $t5	# t9 <= 122?
	add $s2, $s0, $s1	# neu $s2 = 2 thi no la chu in thuong
	addi $s2, $s2, -2	# neu $s2 = 0 thi no la chu in thuong
	bgezal $s2, thuong_sang_hoa	# cac truong hop con lai giu nguyen
	addi $t1, $t1,1
	addi $t0, $t0,1	
	
loop: 
	beq $t1, $t0, endloop
check_thuong:	
	lb $a1, 0($a0)	#a1 chua string[i-1]
	addi $a0, $a0,1
	lb $t9, 0($a0)	#t9 chua string[i]
	sge $s0, $t9, $t4	# t9 >= 97?
	sle $s1, $t9, $t5	# t9 <= 122?
	add $s2, $s0, $s1	# neu $s2 = 2 thi no la chu in thuong
	sle $s3, $a1, $t6	# neu string[i-1] la dau cach thi $s3=1
	add $s2, $s2, $s3	# neu =3 thi can chuyen thuong thanh hoa
	addi $s2, $s2, -3	# neu $s2 = 0 thi no can chuyen thuong thanh hoa
	bgezal $s2, thuong_sang_hoa	
	bne $s2, $0, check_hoa		# neu khong thoa man thi tiep luc check
	addi $t1, $t1,1
	addi $t8, $t8,1
	j loop
check_hoa:
	sge $s0, $t9, $t2	# t9 >= 65?
	sle $s1, $t9, $t3	# t9 <= 90?
	add $s2, $s0, $s1	# neu $s2 = 2 thi no la chu in hoa
	sgt $s3, $a1, $t6	# neu string[i-1] khong phai dau cach thi $s3=1
	add $s2, $s2, $s3	# neu =3 thi can chuyen hoa sang thuong
	addi $s2, $s2, -3	# neu $s2 = 0 thi no can chuyen hoa sang thuong
	bgezal $s2, hoa_sang_thuong	# cac truong hop con lai giu nguyen
	addi $t1, $t1,1
	addi $t8, $t8,1
	j loop
endloop:
	li $v0, 4			# In ra thong bao
	la $a0, message2
	syscall
	li $v0, 4
	la $a0, string
	syscall
Exit:
	li $v0,10
	syscall
	
#input: $t9 chua chu thuong can bien doi
#	$a0 chua dia chi cua ky tu do
#Khong co return 
thuong_sang_hoa:
	addi $t9,$t9, -32	# ma ascii -32
	sb $t9, 0($a0)
	jr $ra
#input: $t9 chua chu hoa can bien doi
#	$a0 chua dia chi cua ky tu do
#Khong co return 
hoa_sang_thuong:
	addi $t9,$t9, 32	# ma ascii +32
	sb $t9, 0($a0)
	jr $ra
