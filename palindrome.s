#Jiaying Wang -- 09/15/15
#palindrome.s -- A MIPS palindrome integer checker
#Registers used:
#		v0		- system parameter and return value
#		a0		- system parameter --strings to print
#		t0		-	used to hold value of reverse
.data
fir_msg: .asciiz		"Programming assignment 1 for CDA3101\n"

sec_msg: .asciiz		"This palindrome checker only deals with positive integer number.\n"

input_msg: .asciiz		"Enter a number to check if it is a palindrome or not.\n"

isPalindrome_msg: .asciiz		"is a palindrome number.\n"

NotPalindrome_msg: .asciiz		"is not a palindrome number.\n"


		.text
main:
		li		$t0, 0			#load 0 into $t0 reverse

		la		$a0,	fir_msg
		li		$v0,	4
		syscall

		la		$a0,	sec_msg
		li		$v0,	4
		syscall

		la		$a0, input_msg
		li		$v0,	4
		syscall

		li		$v0, 5			#load system read_int call into v5
		syscall						#make the system call
		move	$t1, $v0		#move the number read
