.globl main
.data
    msg1: .asciiz "Enter the number : "
    space: .asciiz " "

.text
main:
    li $v0,4
    la $a0,msg1
    syscall

    li $v0,5
    syscall

    move $s0,$v0

    li $t0,0 
    li $t1,1
    li $s1,0

loop:
    slt $s2,$s1,$s0
    beq $zero,$s2,end_loop

    li $v0,1
    move $a0,$t0
    syscall
    
    li $v0,4
    la $a0,space
    syscall

    move $t2,$t1
    add $t1,$t0,$t1
    move $t0,$t2
    
    addi $s1,1
    j loop

end_loop:
    li $v0,10
    syscall