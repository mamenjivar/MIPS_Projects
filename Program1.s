# Miguel Menjivar
# Program #1
# CS 264
# 
# Purpose: Prints out strings 


.data
helloWorld: .asciiz  "Hello World"
name: .asciiz "Miguel Menjivar"
videoGame: .asciiz "Call of Duty: Modern Warfare 2"
favoriteFilm: .asciiz "The Avengers: Infinity War"
favoriteSong: .asciiz "Motorsport"
artist: .asciiz "Migos"
return: .asciiz "\n"

.text
.globl main

main:
	la $a0, helloWorld # hello world string
	li $v0, 4
	syscall
	
	la $a0, return # new line
	li $v0, 4
	syscall
	
	la $a0, name # My name
	li $v0, 4
	syscall
	
	la $a0, return # new line
	li $v0, 4
	syscall
	
	la $a0, videoGame # favorite video game string
	li $v0, 4
	syscall
	
	la $a0, return # new line
	li $v0, 4
	syscall
	
	la $a0, favoriteFilm # favorite film string
	li $v0, 4
	syscall
	
	la $a0, return # new line
	li $v0, 4
	syscall
	
	la $a0, favoriteSong # favorite song string
	li $v0, 4
	syscall
	
	la $a0, return # new line
	li $v0, 4
	syscall
	
	la $a0, artist # artist name string
	li $v0, 4
	syscall
	
li $v0, 10 # terminate the program
syscall
