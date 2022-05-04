.globl main
.data
    msg1: .asciiz "Enter the first string : "
    msg2: .asciiz "Enter the second string : "
    ans: .asciiz "Output string : "
    output: .space 500
    string1: .space 500
    string2: .space 500

.text
main:
    li $v0,4
    la $a0,msg1
    syscall
    
    li $v0,8
    la $a0,string1
    li $a1,500
    syscall
    
    li $v0,4
    la $a0,msg2
    syscall
    
    li $v0,8
    la $a0,string2
    li $a1,500
    syscall
    
    la $s0,string1
    la $s1,string2
    la $s2,output

loop1:
    lb $t0,($s0)
    beq $t0,$zero,loop2
    addi $t1,$zero,10
    beq $t0,$t1,loop2
    sb $t0,($s2)
    addi $s0,$s0,1
    addi $s2,$s2,1
    j loop1

loop2:
    lb $t0,($s1)
    beq $t0,$zero,print
    sb $t0,($s2)
    addi $s1,$s1,1
    addi $s2,$s2,1
    j loop2

print:
    li $v0,4
    la $a0,ans
    syscall
    
    li $v0,4
    la $a0,output
    syscall
    
    li $v0,10
    syscall