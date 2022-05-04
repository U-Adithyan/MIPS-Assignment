.globl main
.data
    msg1: .asciiz "Enter the Sentence : "
    ans1: .asciiz "The Longest Word : "
    ans2: .asciiz "The Shortest Word : "
    space: .asciiz " "
    enter: .asciiz "\n"
    string: .space 500

.text
main:
    li $v0,4
    la $a0,msg1
    syscall
    
    li $v0,8
    la $a0,string
    li $a1,500
    syscall

    addi $t0,$zero,0
    addi $t1,$zero,0
    addi $t2,$zero,500
    la $s0,string
    
search:
    lb $t3,($s0)
    addi $t4,$zero,32
    beq $t3,$t4,check
    addi $t4,$zero,10
    beq $t3,$t4,check
    beq $t3,$zero,print
    addi $s0,$s0,1
    addi $t0,$t0,1
    j search

check:
    bgt $t0,$t1,update_max
    blt $t0,$t2,update_min
    addi $t0,$zero,0
    addi $s0,$s0,1
    j search

update_max:
    addi $t1,$t0,0
    addi $t0,$zero,0
    addi $s0,$s0,1
    j search

update_min:
    addi $t2,$t0,0
    addi $t0,$zero,0
    addi $s0,$s0,1
    j search

print:
    la $s0,string
    addi $t0,$zero,0

    li $v0,4
    la $a0,ans1
    syscall

    j max_loop

max_loop:
    lb $t3,($s0)
    addi $t4,$zero,32
    beq $t3,$t4,check_max
    addi $t4,$zero,10
    beq $t3,$t4,check_max
    beq $t3,$zero,print_min
    addi $s0,$s0,1
    addi $t0,$t0,1
    j max_loop

check_max:
    bne $t0,$t1,skip1
    sub $s0,$s0,$t0
loop1:
    lb $a0,0($s0)
    li $v0,11
    syscall
    
    addi $s0,$s0,1
    addi $t0,$t0,-1
    bne $t0,$zero,loop1
    addi $s0,$s0,1
    
    li $v0, 4
    la $a0, space
    syscall
    
    j max_loop
skip1:
    addi $s0,$s0,1
    addi $t0,$zero,0
    j max_loop

print_min:
    la $s0,string
    addi $t0,$zero,0

    li $v0,4
    la $a0,enter
    syscall

    li $v0,4
    la $a0,ans2
    syscall

    j min_loop

min_loop:
    lb $t3,($s0)
    addi $t4,$zero,32
    beq $t3,$t4,check_min
    addi $t4,$zero,10
    beq $t3,$t4,check_min
    beq $t3,$zero,exit
    addi $s0,$s0,1
    addi $t0,$t0,1
    j min_loop

check_min:
    bne $t0,$t2,skip2
    sub $s0,$s0,$t0
loop2:
    lb $a0,0($s0)
    li $v0,11
    syscall
    
    addi $s0,$s0,1
    addi $t0,$t0,-1
    bne $t0,$zero,loop2
    addi $s0,$s0,1
    
    li $v0,4
    la $a0,space
    syscall
    
    j min_loop
skip2:
    addi $s0,$s0,1
    addi $t0,$zero,0
    j min_loop

exit:
    li $v0,10
    syscall