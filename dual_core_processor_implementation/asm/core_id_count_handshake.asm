li $t0 0x2000
lw  $s7, 0($t0)

li $t7 0
li $t6 0x2000
sw $t7, 0($t6)

li $t6 0x2004
sw $t7, 0($t6)

li $t3 0x2004
sw $t7, 0($t3)

beq $s7,$zero,core_id_0
beq $s7,1,core_id_1
j exit

core_id_0:
    addi $a0, $zero, 0        # b
    addi $t0, $zero, 0        # a
    addi $t1, $zero, 1	      # Sum
    addi $t2, $zero, 1	      # counter
    add $t7, $t1, $t2 

    #li $t4 0x00000010
    #li $t4 0x3000
    li $t6 0x2048
    sw  $t7, 0($t6)

    li $t5 0
    li $t6 0

    li $t5 0x2000
    lw  $t6, 0($t5)
    addi $t6, $t6, 1
    sw  $t6, 0($t5)

    add $a0,$t7,$t0      #return (the answer t0 is 0)
    j exit

core_id_1:
    #addi $t5, $zero, 0        # b
    addi $t0, $zero, 2        # a
    addi $t1, $zero, 2	      # Sum
    add $t2, $t0, $t1 	      # counter
    li $t6 0x2000
    li $t7 0x2004

    check_counter:
        lw  $t4, 0($t6)
        lw  $t5, 0($t3)
        bne $t4, $t5, core_1_continue
        j check_counter
 
    core_1_continue:
    #li $t4 0x00000010
    #li $t4 0x3000
    li $t6 0x2048
    lw  $t7, 0($t6)

    li $t5 0x2004
    lw  $t6, 0($t5)
    addi $t6, $t6, 1
    sw  $t6, 0($t5)

    add $a0, $t7, $t2 
    j exit


exit:    
    addi $v0,$zero,1        #set syscall type to print int
    SYSCALL                 #print $a0
    addi $v0,$zero,10       #set syscall type to exit 
    SYSCALL                 #exit

loop:
    nop
    j loop