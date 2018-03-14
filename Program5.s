# Author: Miguel Menjivar
# Class: CS264-02
#
# Assignment: Program 5
# Date: 2/28/2018
# Purpose: A program that utilizes methods

.data
array: .space 120 # holds records for all information 
size: .space 11
string: .space 20000
menuPrompt: .asciiz "Menu:"
optionOne: .asciiz "1) Swap two records."
optionTwo: .asciiz "2) Exit"
response: .asciiz "Please choose one of the above options: "
introPrompt: .asciiz "Enter the name, age, and ID for 10 students please:"
newSpace: .asciiz " "
newLine: .asciiz "\n"
record: .asciiz "Record "
colon: .asciiz ": "
record1: .asciiz "Which record do you select first? "
record2: .asciiz "Which record do you want to swap it with? " 

.text
.globl main

main:
	la $a0, introPrompt # prompts user to insert array values
	li $v0, 4
	syscall
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	jal createArray # populates the array, then prints it out
	
menu:
	la $a0, menuPrompt # menu string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	la $a0, optionOne # swap two records string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	la $a0, optionTwo # exit string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	la $a0, response # please choose option string
	li $v0, 4
	syscall
	
	li $v0, 5 # gets user response
	syscall
	
	beq $v0, 1, swapRecords # switches records within array
	beq $v0, 2, exit # ends program
	
createArray:
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	li $t0, 0 # t0 is loop counter
	li $t1, 0 # t1 is array counter
	la $s2, string # allocated over 1000 bytes
	
loopArray:
	beq $t1, 30, ExitLoopArray # edit original 30
	
	move $a0, $s2 # get the string
	#la $a0, size
	li $a1, 40 # max number of characters 10
	li $v0, 8
	syscall
	
	# store pointer to string into array
	sw $a0, array($t0)
	
	addi $t0, $t0, 4 # increase array location
	addi $t1, $t1, 1 # increases loop counter
	addi $s2, $s2, 40 # advance to next space of string
	
	j loopArray
	
ExitLoopArray:
	addi $sp, $sp -4 # opens up a stack
	sw $ra, 0($sp) # stores location jump
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	jal printArray
	
	lw $ra, 0($sp) # return the stack with initial jump
	addi $sp, $sp, 4
	
	jr $ra
	
printArray:
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	li $t0, 0 # array counter
	li $t1, 0 # loop counter 
	li $t3, 1 # outter loop counter and print integer value
	
outterLoop:
	beq $t3, 11, exitPrintLoop # edit original 11 add 1 to desired amount
	 
	la $a0, record # new line string
	li $v0, 4
	syscall
	
	add $a0, $zero, $t3 # prints record number
	li $v0, 1
	syscall
	
	la $a0, colon # new line string
	li $v0, 4
	syscall
	
	li $t1, 0 # t1 is loop counter
	
printLoop:
	beq $t1, 3, exitInnerLoop
	
	lw $t2, array($t0)
	
	li $v0, 4 # print out string
	move $a0, $t2
	syscall
	
	#la $a0, newSpace # space
	#li $v0, 4
	#syscall
	
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	
	j printLoop
	
exitInnerLoop:
	addi $t3, $t3, 1
	
	j outterLoop
	
exitPrintLoop:
	la $a0, newLine # new line string
	li $v0, 4
	syscall

	jr $ra

swapRecords:
	# t5 holds option 1 value
	# t6 holds option 2 value
	# t8 holds temp value for first record
	# t9 holds temp value for second record
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	la $a0, record1 # prompts user for first record to switch
	li $v0, 4
	syscall
	
	li $v0, 5 # gets user response
	syscall
	
	sub $t5, $v0, 1 # subtracts 1 from input for array location
	mul $t5, $t5, 3 # multiplies input by 3 for record location
	mul $t5, $t5, 4 # multiplies record number by 4 for array location
	
	la $a0, record2 # prompts user for second record to switch
	li $v0, 4
	syscall
	
	li $v0, 5 # gets user response
	syscall
	
	sub $t6, $v0, 1 # subtracts 1 from user for array location
	mul $t6, $t6, 3 # multiplies by 3 to get record location
	mul $t6, $t6, 4 # multiplies by 4 for array location
	
	li $t3, 0 # loop counter
	
swapLoop:
	beq $t3, 3, endSwapLoop
	
	lw $t8, array($t5) # loads value of first record given by user
	lw $t9, array($t6) # loads value of second record given by user
	
	sw $t8, array($t6) # stores value of first record into second record
	sw $t9, array($t5) # stores value of second regirster into first register
	
	addi $t3, $t3, 1 # incrememnts loop counter
	addi $t5, $t5, 4 # incrememnts to next value in array to swap
	addi $t6, $t6, 4 # increments to next value in array to swap
	
	j swapLoop
	
endSwapLoop:
	jal printArray
	
	j menu

exit:
	li $v0, 10 # end of program
	syscall
