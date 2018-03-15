# Author: Miguel Menjivar
#
# Date: 3/14/2018
# 
# Fibonacci Sequence

.data
array: .byte 40
title: .asciiz "The Fibonacci Sequence"
newLine: .asciiz "\n"
mainMenu: .asciiz "Main menu"
optionOne: .asciiz "1) Compute a value"
optionTwo: .asciiz "2) Exit"
decision: .asciiz "Choose an option: "
fibNumber: .asciiz "Input number: "
fibResult: .asciiz "The result is: "
.text
.globl main

main:
	la $a0, title # "The Fibonacci Sequence" string
	li $v0, 4
	syscall
	
	jal return # adds 2 new lines for padding purposes
	jal return
	
menu:
	la $a0, mainMenu # "Main menu" string
	li $v0, 4
	syscall
	
	jal return # new line
	
	la $a0, optionOne # "compute a value" string
	li $v0, 4
	syscall

	jal return # new line
	
	la $a0, optionTwo # "exit program" string
	li $v0, 4
	syscall
	
	jal return # new line
	
	la $a0, decision # "choose option" string
	li $v0, 4
	syscall
	
	li $v0, 5 # get choice from user
	syscall
	
	beq $v0, 1 computeFib 
	beq $v0, 2 exit
	
computeFib:
	jal return # new line
	
	la $a0, fibNumber # "enter fib number" string
	li $v0, 4
	syscall	
	
	li $v0, 5 # gets fib number to be computed by user
	syscall
	
	move $t4, $v0 # value given by user t4 = v0	

	li $t0, 0 # first value
	li $t5, 0 # array counter first value
	li $t1, 1 # second value
	li $t6, 1 # array counter second value
	li $t2, 0 # t2 result 3rd value
	li $t7, 2 # array counter answer
	li $t3, 0 # loop counter initialized to 0
	# t4 = value given by user
	
	sb $t0, array($t5) # 0
	sb $t1, array($t6) # 1
	
fibLoop:
	beq $t4, 0, baseCaseZero # if chosen values are 1 or 0
	beq $t4, 1, baseCaseOne
	
preLoop:
	beq $t3, $t4, fibExit
	
	lb $t0, array($t5) # loads first value to t0
	lb $t1, array($t6) # loads second value to t6
	
	add $t2, $t1, $t0 $ # t2 = t1 + t0
	
	sb $t2, array($t7) # stores value t2 to 2nd location in array
	
	addi $t5, $t5, 1 # increments all array counters by 1
	addi $t6, $t6, 1
	addi $t7, $t7, 1

	addi $t3, $t3, 1 # increment loop counter by 1
	
	j preLoop

baseCaseZero:
	la $a0, fibResult # "fib number result" string
	li $v0, 4
	syscall

	lb $a0, array($t4) # prints the 0th term in the array
	li $v0, 1
	syscall
	
	jal return # adds 2 new lines for spacing purposes
	jal return
	
	j menu

baseCaseOne:
	la $a0, fibResult # "fib number result" string
	li $v0, 4
	syscall

	lb $a0, array($t4) # print the 1st term in the array
	li $v0, 1
	syscall
	
	jal return # adds 2 new lines for spacing purposes
	jal return
	
	j menu
	
fibExit:
	la $a0, fibResult # "fib number result" string
	li $v0, 4
	syscall
	
	subi $t7, $t7, 2 
	
	lb $a0, array($t7) # prints value of fib result
	li $v0, 1
	syscall

	jal return # adds 2 new lines for spacing purposes
	jal return
	
	j menu
	
return:
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	jr $ra
exit:
	li $v0, 10 # exits program
	syscall
