.data
	string: .space 500
	message1: .asciiz "Nhap xau ky tu: "
	error: .asciiz "ERROR: Khong duoc de trong. Vui long nhap lai\n"
	message2: .asciiz "Xau doi xung"
	message3: .asciiz "Xau khong doi xung"
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
EndLength: 			# t0= do dai xau

main:
	addi $t0,$t0,-1 	# dung de tro vao cuoi string
	la $a1, string
	add $a1,$a0,$t0	# $a1 tro vao cuoi string
loop:
	sgt $t2,$a0,$a1	#con tro dau > con tro cuoi thi xau doi xung
	bne $t2,$0,dx
	lb $t0, 0($a0)	#load gia tri vao $t0 va $t1
	lb $t1, 0($a1)
	bne $t0, $t1, kdx	#hai ma asciiz khong bang nhau thi khong doi xung
	addi $a0,$a0,1	#con tro dau +1
	addi $a1,$a1,-1	#con tro cuoi -1
	j loop
kdx:
	li	$v0, 4		# Thong bao khong doi xung
	la	$a0, message3
	syscall
	j Exit
dx:
	li	$v0, 4		# Thong bao doi xung
	la	$a0, message2
	syscall
Exit:
	li $v0,10
	syscall