# Miguel Menjivar
# Program #2
# CS 264
#
# Purpose: Prompts user to enter 10 values and then
#      and then prints out the average of those 10 values

.data
integer1: .asciiz "Please enter an integer: "
integer2: .asciiz "Please enter another integer: "
average: .asciiz "The average of your numbers is: "
newLine: .asciiz "\n"

.text
.globl main

main:
	la $a0, integer1 # enter first integer string
	li $v0, 4
	syscall
	
	li $v0, 5 # get first integer value
	syscall
	
	move $t0, $v0 # move value of $v0 to $t0
	
	la $a0, integer2 # get second integer string
	li $v0, 4
	syscall
	
	li $v0, 5 # get second integer value
	syscall
	
	move $t1, $v0 # move value of $v0 to $t1
	
	la $a0, integer2 # third integer string
	li $v0, 4
	syscall
	
	li $v0, 5 # get third integer value
	syscall
	
	move $t2, $v0 # move value of $v0 to $t2
	
	la $a0, integer2 # fourth integer string
	li $v0, 4
	syscall
	
	li $v0, 5 # get fourth integer value
	syscall
	
	move $t3, $v0 # move value of $v0 to $t3
	
	la $a0, integer2 # fifth integer string
	li $v0, 4
	syscall
	
	li $v0, 5 # get fifth integer value
	syscall
	
	move $t4, $v0 # move value of $v0 to $t4
	
	add $t5, $t0, $t1
	add $t5, $t5, $t2
	add $t5, $t5, $t3
	add $t5, $t5, $t4
	
	div $t6, $t5, 5
	
	la $a0, average
	li $v0, 4
	syscall 
	
	li $v0, 1
	add $a0, $zero, $t6
	syscall
	
li $v0, 10 # end of program
syscall
