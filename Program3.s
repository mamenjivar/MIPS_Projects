# Author: Miguel Menjivar
# Class: CS 264-02
#
# Assignment: Program 3
# Date: 2/2/2018
#
# Purpose: A program to work with arrays allowing the user to remove
#      or edit values and see the result. When exiting, the program
#      computes the sum and product of the remaining values

.data
array: .space 40 # 10 elements for the array
tempArray: .space 40 # 10 elements for temporary array
prompt1: .asciiz "Please enter 10 integer values: "
prompt2: .asciiz "Your values are: "
menu: .asciiz "Menu (enter an int as your choice): "
choice1: .asciiz "1) Replace an element at a certain position"
choice2: .asciiz "2) Remove the max element"
choice3: .asciiz "3) Remove the min element "
choice4: .asciiz "4) Compute values and exit"
prompt3: .asciiz "What would you like to do? "
newLine: .asciiz "\n"
newSpace: .asciiz " "
sum: .asciiz "The summation of all values in the array is: "
product: .asciiz "The product of all values in the array is: "
replacePrompt1: .asciiz "What position from the array do you wish to replace? "
replacePrompt2: .asciiz "What value do you want to change it to? "
maxEx: .asciiz "Max value is: "
minEx: .asciiz "Min value is: "

.text
.globl main

main:
	la $a0, prompt1 # first prompt string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
inputLoop:
	li $v0, 5 # get value from user keyboard
	syscall
	
	sw $v0, array($t0) # store value into array
	
	addi $t0, $t0, 4 # increment value to next space in array
	
	bne $t0, 40, inputLoop # loops until reaching end of array
	
	addi $t0, $zero, 0 # sets value back to zero
	
	la $a0, newLine # new line string
	li $v0, 4
	syscall
	
	la $a0, prompt2 # display values prompt
	li $v0, 4
	syscall
	
print:
	li $t0, 0
	li $t1, 0
	
printLoop:
	beq $t0, 40, command
	
	lw $t1, array($t0) # loads integer of array to t1
	
	li $v0, 1 # prints number in array
	move $a0, $t1
	syscall
	
	addi $t0, $t0, 4 # increments to next integer in array

	la $a0, newSpace # spaces out array	
	li $v0, 4
	syscall
	
	j printLoop
	
command:	
	la $a0, newLine # new line
	li $v0, 4
	syscall	

	la $a0, menu # menu string
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
	la $a0, choice1 # first choice
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
	la $a0, choice2 # second choice
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	la $a0, choice3 # third choice
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
	la $a0, choice4 # fourth choice
	li $v0, 4
	syscall
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	la $a0, prompt3 # third prompt
	li $v0, 4
	syscall
	
	li $v0, 5 # get choice decision from user
	syscall
	
	beq $v0, 1, replace # replace block
	beq $v0, 2, removeMax # remove max block
	beq $v0, 3, removeMin # remove min block
	beq $v0, 4, compute # compute values and exit block
	
replace:
	la $a0, newLine # new line
	li $v0, 4
	syscall

	la $a0, replacePrompt1 # replace element string
	li $v0, 4
	syscall
	
	li $v0, 5 # get choice decision from user
	syscall # where in array to replace number
	
	move $t0, $v0 # holds element of array (position)
	
	sub $t0, $t0, 1 # subtract 1 from user input as they might not start from zero
	mul $t0 $t0, 4 # multiply user input by 4 for the array
	
	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
	la $a0, replacePrompt2 # replace element string
	li $v0, 4
	syscall
	
	li $v0, 5 # choice of number that wants to be replace
	syscall
	
	sw $v0, array($t0) # replaces the number in the position specified by user
	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	j print # jumps to print block and prints out the new array

removeMax:
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	li $t0, 0 # resets t0 back to 0
	li $t1, 1 # resets t1 to 1 for counter
	lw $t3, array($t0) # loads integer of array to t3
	
loopMax:
	beq $t1, 10, exitMax # exit if we reach end of array
	
	addi $t0, $t0, 4 # increment pointer by 1 word
	addi $t1, $t1, 1 # increment loop counter
	
	lw $t2, array($t0) # store array value into t2
	ble $t2, $t3, end_if # compares the two values
	
	move $t3, $t2 # found a new maximum, store it into t3

end_if:
	j loopMax

exitMax:
	li $t0, 0 # resets t0 back to 0 for array
	li $t1, 1 # resets t1 back to 1 for counter 
	li $t2, 0 # resets t2 to 1 for temporary array
	
loopTemp:
	beq $t0, 40, exitTemp
	
	lw $t4, array($t0) # loads integer to t4
	
	beq $t3, $t4, temp # if integers equal don't add max value
	
	sw $t4, tempArray($t2)
	
	addi $t0, $t0, 4
	addi $t2, $t2, 4
	addi $t1, $t1, 1
	
	j loopTemp

temp:
	li $t4, 0
	sw $t4 array($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	
	j loopTemp
	
exitTemp:
	li $t0, 0 # resets t0 back to 0 increment array
	li $t1, 1 # resets t1 to 1 for counter

copyArray:
	beq $t1, 10, exitCopy
	
	lw $t4, tempArray($t0)
	sw $t4, array($t0)
	
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	
	j copyArray

exitCopy:
	j print
	
removeMin:	
	la $a0, newLine # new line
	li $v0, 4
	syscall
	
	li $t0, 0 # resets t0 back to 0
	li $t1, 1 # resets t1 to 1 for counter
	lw $t3, array($t0) # loads integer of array to t3

loopMin:
	beq $t1, 10, exitMin
	
	addi $t0, $t0, 4 # points to next word in array
	addi $t1, $t1, 1 # increments counter
	
	lw $t2, array($t0)
	beq $t2, 0, end_iff # ignores the zero value for min value
	bge $t2, $t3, end_iff # checks if t2 > t3
	
	move $t3, $t2 # holds the minimum value
	
end_iff:
	j loopMin
	
exitMin:
	li $t0, 0 # resets t0 to 0
	li $t1, 1 # resets t1 to 1
	li $t2, 0 # resets t2 to 0
	
loopTempMin:
	beq $t0, 40, exitTempMin
	
	lw $t4, array($t0)
	
	beq $t3, $t4, tempMin
	
	sw $t4, tempArray($t2)
	
	addi $t0, $t0, 4
	addi $t2, $t2, 4
	addi $t1, $t1, 1
	
	j loopTempMin

tempMin:
	li $t4, 0
	sw $t4 array($t0)
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	
	j loopTempMin

exitTempMin:
	li $t0, 0
	li $t1, 1
	
copyArrayMin:
	beq $t1, 10, exitCopyMin
	
	lw $t4, tempArray($t0)
	sw $t4, array($t0)
	
	addi $t0, $t0, 4
	addi $t1, $t1, 1
	
	j copyArrayMin
	
exitCopyMin:
	j print
	
compute:
	li $t0, 0 # resets t0 back to zero
	li $t2, 0 # resets t2 back to zero
	li $t3, 1 # sets t3 to 1 for multiplication reasons
	
	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
loop:
	beq $t0, 40, exit # t0 == 40 then exit branch
	
	lw $t1, array($t0) # loads integer of array to t1
	
	addi $t0, $t0, 4 # increments to next integer in array
	
	beq $t1, 0, loopJump
	
	add $t2, $t2, $t1 # adds all values inside array
	mul $t3, $t3, $t1 # multiplies values inside array
	
loopJump:	
	j loop
	
exit:
	la $a0, sum # sums all the integers in array string
	li $v0, 4
	syscall 
	
	li $v0, 1  # prints sum of integers in array
	add $a0, $zero, $t2
	syscall

	la $a0, newLine # new line
	li $v0, 4
	syscall	
	
	la $a0, product # product all the integers in array string
	li $v0, 4
	syscall
	
	li $v0, 1 # prints product
	add $a0, $zero, $t3
	syscall
	
	li $v0, 10 # end of program
	syscall
