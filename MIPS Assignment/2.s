.globl main
.data
    msg1: .asciiz "Enter the first number : "
    msg2: .asciiz "Enter the Second number : "
    ans1: .asciiz "They are twin prime\n"
    ans2: .asciiz "They are not twin prime\n"
    enter: .asciiz "\n"

.text
main:
    li $v0,4
    la $a0,msg1
    syscall

    li $v0,5
    syscall
    move $s0,$v0

    li $v0,4
    la $a0,msg2
    syscall

    li $v0,5
    syscall
    move $s1,$v0

    move $a0,$s0
	jal	is_prime
    beq $zero,$v0,not_twinprime

    move $a0,$s1
	jal	is_prime
    beq $zero,$v0,not_twinprime

    slt $t2,$s1,$s0
    beq $zero,$t2,case

    addi $t0,$s1,2
    bne $s0,$t0,not_twinprime

    j twinprime

case:
    addi $t0,$s0,2
    bne $s1,$t0,not_twinprime
    j twinprime

not_twinprime:
    li $v0,4
    la $a0,ans2
    syscall

    j end

twinprime:
    li $v0,4
    la $a0,ans1
    syscall

    j end

end:
    li $v0,10
    syscall

is_prime:
    addi $t0,$zero,2
    beq $a0,1,not_prime

loop:
    beq $t0,$a0,prime

    div $a0,$t0
    mfhi $t1
    beq $t1,$zero,not_prime

    addi $t0,$t0,1
    j loop

prime:
    addi $v0,$zero,1
    jr $ra
not_prime:
    add $v0,$zero,$zero
    jr $ra