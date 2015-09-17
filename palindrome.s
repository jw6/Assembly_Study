#Jiaying Wang -- 09/15/15
#palindrome.s -- A MIPS palindrome integer checker
#Registers used:
#		v0		- system parameter and return value
#		a0		- system parameter --strings to print
#		t0		-	used to hold value of reverse
#		t1		- used to hold value of num
#		t2		- used to hold value of temp

.data
fir_msg: .asciiz		"Programming assignment 1 for CDA3101\n"

sec_msg: .asciiz		"This palindrome checker only deals with positive integer number.\n"

input_msg: .asciiz		"Enter a number to check if it is a palindrome or not.\n"

Is_Pal_msg: .asciiz		"is a palindrome number.\n"

Not_Pal_msg: .asciiz		"is not a palindrome number.\n"


		.text
main:
		li		$t0,	0			#load 0 into $t0 reverse
		li		$t8,	10		#load 10 into $t8
		##print the welcome message
		la		$a0,	fir_msg
		li		$v0,	4
		syscall

		la		$a0,	sec_msg
		li		$v0,	4
		syscall

		##print the read_int message
		la		$a0,	input_msg
		li		$v0,	4
		syscall

		li		$v0, 5			#load system read_int call into v0
		syscall						#make the system call
		move	$t1,	$v0		#move the number read, store num

		move	$t2,	$t1		#copy the value of num into temp

		jal while_loop

while_loop:
		blez	$t2,	endloop			#check if temp equals 0

		mult	$t0,	$t8	#reverse multply by 10
		mflo	$t3					#temp value to hold result
		move	$t0,	$t0		#move the value into reverse

		div		$t2,	$t8		#temp divided by 10
		mfhi	$t3					#temp value to hold remainder temp % 10
		mflo	$t2					#temp value to hold t2

		add		$t0,	$t0,	$t3		#reverse = reverse + temp % 10

		b		while_loop

endloop:
		beq		$t1,	$t2,	Is_Pal
		bne		$t1,	$t2,	Not_Pal


Is_Pal:
		la		$a0,	$t0
		li		$v0,	1
		syscall

		la		$a0,	Is_Pal_msg
		li		$v0,	4
		syscall

		j		Exit

Not_Pal:
		la		$a0,	$t0
		li		$v0,	1
		syscall

		la		$a0,	Not_Pal_msg
		li		$v0,	1
		syscall

		j		Exit

Exit:
		li	$v0,	10
		syscall
