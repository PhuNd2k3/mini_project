.data
	string: .space 500
	message1: .asciiz "Nhap xau ky tu: "
	error: .asciiz "ERROR: Khong duoc de trong. Vui long nhap lai\n"
	message2: .asciiz "Cac tu khong trung lap la"
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
	lb	$t2, 0($t2)			# Lay ra string[i] = $t2
	beq	$t2, 10, Check		# Kiem tra neu string[i] ='\n' thi ket thuc Length
	addi	$t0, $t0, 1 		# i++
	j	Length
Check: 	bne 	$t0, $0, EndLength		# $t0 khac khong thi khong loi
	li	$v0, 4			# Thong bao loi
	la	$a0, error
	syscall	
	j NhapXau
EndLength: 			# t0= do dai xau, $a0 van chua dia chi xau

main:
	li $a1, 0		# a1 = i cho vong for 1
	addi $a2, $a0, 0	# a2 cung tro vao sting
	move $fp,$sp
loop1:
	beq $a1, $t0, end_loop1	#thoat vong for khi i= do dai xau
	add $a2, $a0, $a1	# a2= address string[i]
	lb $t1, 0($a2)
	sb $t1, 0($sp)
	addi $a1,$a1,1
	addi $sp,$sp,-1
	j loop1
end_loop1:			#string duoc luu trong khoang tu $sp den $fp

	li $a1, 0
	addi $a2, $a0, 0	#restore lai cho for 2
	addi $t1, $0, 1	# t1 =1, cac so xuat hien 1 lan se in
loop2:
	beq $a1, $t0, end_loop2
	add $a2,$a0,$a1
	lb $a3, 0($a2)
	jal check
	beq $v1, $t1, print
continue:	addi $a1,$a1,1
	j loop2
end_loop2:	
	
Exit:	
	addi $sp, $fp, 0
	addi $fp,$0, 0
	li $v0, 10
	syscall

# dung hai con tro $fp $sp
# input $a3
# return $v1 = so lan xuat hien
check:
	li $v1, 0
	addi $t1, $sp, 0
tim_so_lan:
	sgt $t3,$t1,$fp
	bne $t3, $0, end_tim_so_lan
	lb $t2, 0($t1)
	addi $t1,$t1,1
	beq $a3, $t2, tang1
	j tim_so_lan
tang1:
	addi $v1,$v1,1
	j tim_so_lan
end_tim_so_lan:
	li $t1,1
	jr $ra
	
print:	li $v0, 11
	add $a0, $zero, $a3
	syscall
	la $a0, string
	j continue
