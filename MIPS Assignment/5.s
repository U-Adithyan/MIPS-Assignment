.globl main
.data
    msg1: .asciiz "Enter the Sentence : "
    msg2: .asciiz "Enter the Word to Search : "
    msg3: .asciiz "Enter the Word to Replace : "
    ans: .asciiz "The Sentence after Replacement : "
    output: .space 500
    string: .space 500
    word1: .space 200
    word2: .space 200

.text
main:
    li $v0,4
    la $a0,msg1
    syscall
    
    li $v0,8
    la $a0,string
    li $a1,500
    syscall

    li $v0,4
    la $a0,msg2
    syscall
    
    li $v0,8
    la $a0,word1
    li $a1,500
    syscall

    li $v0,4
    la $a0,msg3
    syscall
    
    li $v0,8
    la $a0,word2
    li $a1,500
    syscall

    la $s0,string
    la $s1,output
    la $s2,word1
    la $s3,word2
    addi $t5,$zero,0

solve:
    lb $t0,($s0)
    lb $t1,($s2)

    addi $t2,$zero,10
    beq $t1,$t2,replace

    addi $t2,$zero,0
    beq $t0,$t2,print

    bne $t0,$t1,reset
    sb $t0,($s1)
    addi $s0,$s0,1
    addi $s1,$s1,1
    addi $s2,$s2,1
    addi $t5,$t5,1

    j solve

replace:
    addi $t2,$zero,10
    beq $t0,$t2,continue

    addi $t2,$zero,32
    bne $t0,$t2,loop_end
continue:
    sub $s1,$s1,$t5
    loop:
        lb $t3,($s3)
        addi $t2,$zero,10
        beq $t3,$t2,loop_end
        sb $t3,($s1)
        addi $s3,$s3,1
        addi $s1,$s1,1
        j loop
    loop_end:
        sub $s3,$s3,$t5    
        sub $s2,$s2,$t5
        addi $t5,$zero,0
        j solve

reset:
    sb $t0,($s1)
    addi $s0,$s0,1
    addi $s1,$s1,1
    sub $s2,$s2,$t5
    addi $t5,$zero,0

    j solve

print:
    addi $t0,$zero,0
    sb $t0,($s1)

    li $v0,4
    la $a0,ans
    syscall

    li $v0,4
    la $a0,output
    syscall
exit:
    li $v0,10
    syscall