#Jiaying Wang 9/25/15
#This is the second homework assignment for CDA3101
#This code is also on my Github
#https://github.com/jw6/MIPS/blob/master/gcd.s
#gcd.s
#Registers used:
#		v0		- system parameter and return value
#		a0		- system parameter --strings to print
#		t0		-	used to hold temporary value in mflo
#		a1		- used to hold value of int n1
#		a2		- used to hold value of int n2
#		s0		- used to hold original value of n1
#   s1    - used to hold original value of n2

.data

message1: .asciiz "Enter first integer n1: "
message2: .asciiz "Enter second integer n2: "

message3: .asciiz "The greatest common divisor of n1 and n2 is \n"  ;
message4: .asciiz "The least common multiple of n1 and n2 is \n"
newline: .asciiz "\n"

.text
main:
    la    $a0, message1    #print first message
    li    $v0, 4
    syscall

    li    $v0, 5           #load system read_int call into v0
    syscall                #system call
    move  $a1, $v0         #move the number read, store n1

    la    $a0, message2    #print second message
    li    $v0, 4
    syscall

    li    $v0, 5           #load system read_int call into v0
    syscall                #system call
    move  $a2, $v0         #move the number read, store n2

    move $s0, $a1          #save the original value of n1
    move $s1, $a2          #save the original value of n2

gcd:
    sub $sp, $sp, 8   #allocate 2 words in stack
    sw $a1, 0($sp)    #save arg 1
    sw $a2, 4($sp)    #save arg 2
    bnez $a2, else    #if a2 != 0, jump to else
    lw $a1, 0($sp)    #restore arg 1
    lw $a2, 4($sp)    #restore arg 2
    addiu $sp, $sp, 8  #pop 2 words off stack
    jal end_of_gcd    #execute display function

else:
    div $a1, $a2    #divide the a1/a2
    move $a1, $a2   #move the value of a2 into a2
    mfhi $a2        #save the remainder in mfhi
    jal gcd         #goto gcd, run stack again

end_of_gcd:
    la $a0, message3  #display message 3
    li $v0, 4
    syscall

    move $a0, $a1     #display the gcd
    li $v0, 1
    syscall

    la $a0, newline
    li $v0, 4
    syscall

    jal lcm           #jump to lcm

lcm:
    mult $s0, $s1     #compute the product of orginal n1 and n2
    mflo $t0          #save the producte in mflo
    div $t0, $a1      #a1 is the gcd
    mflo $s2          #save the quotient in mflo

    la $a0, message4  #display message4
    li $v0, 4
    syscall

    move $a0, $s2     #display the lcm
    li $v0, 1
    syscall

    j exit

exit:
    li $v0, 10
    syscall
