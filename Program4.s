# Author: Miguel Menjivar
# Class: CS 264-02
#
# Assignment: Program 4
# Date: 2/23/18
# Purpose: A program that utilizes 2D arrays. It will calculate the
#     sum of all the values inside the array.. It will print out the
#     array. It will replace a value inside the array

.data
#array: .space 60 # 5x3 array
array2D: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
option1: .asciiz "1. Replace a value"
option2: .asciiz "2. Calculate the sum of all valus"
option3: .asciiz "3. Print out the 2D array"
option4: .asciiz "4. Exit"
row: .asciiz "Which row: "
column: .asciiz "Which column: "
value: .asciiz "new value: "
sum: .asciiz "The sum of all values: "
newLine: .asciiz "\n"
space: .asciiz " "

.text
.globl main

main:
	la $a0, option1 # option 1 string
	li $v0, 4
	syscall
	
	la $a0, newLine # goes to a new line
	li $v0, 4
	syscall
	
	la $a0, option2 # option 2 string
	li $v0, 4
	syscall
	
	la $a0, newLine # goes to a new line
	li $v0, 4
	syscall
	
	la $a0, option3 # option 3 string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	la $a0, option4 # option 4 string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	li $v0, 5 # gets response from user about choice decision
	syscall
	
	beq $v0, 1, replaceValue # replace value block 
	beq $v0, 2, sumValues # calculate sum of values block
	beq $v0, 3 printArray # print array block
	beq $v0, 4, exit # ends program block
	
replaceValue:
	# t0 hold value of row choice
	# t1 holds value of column choice
	# t2 holds new value given by user
	# t3 holds calculation value for finding row/column
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	la $a0, row # which row string
	li $v0, 4
	syscall
	
	li $v0, 5 # user response for row choice
	syscall
	
	move $t0, $v0 # row choice t0
	
	la $a0, column # which column string
	li $v0, 4
	syscall
	
	li $v0, 5 # user response for column choice
	syscall
	
	move $t1, $v0 # column choice t1
	
	la $a0, value # which value string
	li $v0, 4
	syscall
	
	li $v0, 5 # user response for new value
	syscall
	
	move $t2, $v0 # new value t2
	
	# t0 = row
	# t1 = column
	sub $t0, $t0, 1 # subtracts 1 from row input given by user
	mul $t0 $t0, 12 # multiplies by 12 to point to specicfic row given by user
	sub $t1, $t1, 1 # subtracts 1 from column input given by user
	mul $t1, $t1, 4 # multiplies by 4 to point to specific column given by user
	add $t3, $t0, $t1 # adds the location of both rows and columns to t3
	
	sw $t2, array2D($t3) # stores the value of integer in location specified by user
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	j main

sumValues:
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	li $t0, 0 # loop counter
	li $t1, 0 # array counter
	# t2 holds array value
	li $t3, 0 # will hold value for summation of array

sumLoop:
	beq $t0, 15, sumLoopExit
	
	lw $t2, array2D($t1) # holds value of array in t2
	
	add $t3, $t3, $t2 # add values inside array
	
	addi $t0, $t0, 1 # increment loop counter by 1
	addi $t1, $t1, 4 # increment array counter by 4
	
	j sumLoop	

sumLoopExit:
	la $a0, sum # sum of values string
	li $v0, 4
	syscall
	
	li $v0, 1 # prints out sum
	move $a0, $t3
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	j main
	
printArray:
	li $t1, 0 # array counter
	li $t3, 0 # outter loop counter
	# t2 will hold array value
	# t3 will be row counter
	
printLoop:
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	beq $t3, 5, printExit  # # prints out 5 rows of the array
	
	li $t0, 0 # inner loop counter
	
	addi $t3, $t3, 1 # increments outter loop counter by 1
	

insideLoop:
	beq $t0, 3, exitInsideLoop # prints out 3 columns of array
	
	lw $t2, array2D($t1) # loads array value into t2
	
	li $v0, 1 # prints array value
	move $a0, $t2
	syscall
	
	la $a0, space # new line
	li $v0, 4
	syscall
	
	addi $t0, $t0, 1 # increments loop counter by 1
	addi $t1, $t1, 4 # increments array counter by 4
	
	j insideLoop

exitInsideLoop:
	j printLoop

printExit:
	la $a0, newLine # goes to a new line
	li $v0, 4
	syscall

	j main
	
exit:
	li $v0, 10 # end of program
	syscall
