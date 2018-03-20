# Name: Miguel Menjivar
#
# Date: 3/19/2018
#
# Purpose: Factorials
# will have a main menu to either compute a factorial or exit

.data
title: .asciiz "Factorial"
nLine: .asciiz "\n"
space: .asciiz " "
menuTitle: .asciiz "Menu"
optionOne: .asciiz "1) Compute Factorial"
optionTwo: .asciiz "2) Exit"
factorial: .asciiz "Enter Factorial: "
result: .asciiz "Result: "
decision: .asciiz "Choose one: "
.text
.globl main

main:
	la $a0, title # "Factorial " string
	li $v0, 4
	syscall
	
	jal newLine # adds space between title and menu
	jal newLine
	
menu:
	la $a0, menuTitle # "Menu" string
	li $v0, 4
	syscall
	
	jal newLine # new line
	
	la $a0, optionOne # first choice string
	li $v0, 4
	syscall
	
	jal newLine # new line
	
	la $a0, optionTwo # second choice string
	li $v0, 4
	syscall
	
	jal newLine # new line
	
	la $a0, decision # decision string
	li $v0, 4
	syscall
	
	li $v0, 5 # gets user input 
	syscall
	
	beq $v0, 1, computeFactorial # depending on user input, will jump to designated location
	beq $v0, 2, exit
	
computeFactorial:
	la $a0, factorial # enter factorial string
	li $v0, 4
	syscall
	
	li $v0, 5 # gets factorial user wants to compute
	syscall
	
	move $t0, $v0 # t0 = v0
	li $t1, 1 # t1 = 1 used for multiplying factorial
	
loopFactorial:
	beq $t0, 0, exitLoopFactorial # exit loops once t0 reaches 0
	
	mul $t1, $t1, $t0 # t1 = t1 x t0
	subi $t0, $t0, 1 # t0 = t0 - 1
	
	j loopFactorial
	
exitLoopFactorial:
	la $a0, result # result string
	li $v0, 4
	syscall
	
	move $a0, $t1 # prints result of factorial
	li $v0, 1
	syscall
	
	jal newLine # returns a new line
	
	j menu 
	
newLine:
	la $a0, nLine # returns a new line
	li $v0, 4
	syscall
	
	jr $ra
	
exit:
	li $v0, 10 # end of program
	syscall

