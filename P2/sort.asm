.data
numbers: .word 0 : 100
space: .asciiz " "

.text
   li $v0, 5
   syscall
   move $a1, $v0    #a1 = n
   move $t0, $0     #t0 = i = 0
   move $t1, $0     #t1 = j = 0
   move $t2, $0     #swap
    
   sll $t3, $a1, 2   #t3 = 4*n
input: li $v0, 5
       syscall
       move $a2, $v0   #a2 = numbers[i]
       sw $a2, numbers($t0)  #numbers[i] = a2
       addi $t0, $t0, 4
       bne $t0, $t3, input
       
       addi $t0, $a1, -1  #i = n - 1
sort1: move $t1, $0    # j = 0
       sort2: sll $t3, $t1, 2  # t3 = 4 * j
              lw $s0, numbers($t3)  # s0 = numbers[j]
              addi $t3, $t3, 4  #t3 = t3 + 4
              lw $s1, numbers($t3)  #s1 = numbers]j+1]
              sub $t4, $s0, $s1    #t4 = numbers[j]-numbers[j+1]
              bgtz $t4, swap
              j jup
              swap: sw $s0, numbers($t3)
                    addi $t3, $t3, -4 #
                    sw $s1, numbers($t3)
         jup: addi $t1, $t1, 1 #j ++
              bne $t0, $t1, sort2
       addi $t0, $t0, -1  #i = i - 1       
       bne $t0, $0, sort1

        move $t0, $0 #i = 0
        sll $t1, $a1, 2   #j = 4 * n
output: lw $a0, numbers($t0)
        li $v0, 1
        syscall
        la $a0, space
        li $v0, 4
        syscall
        addi $t0, $t0, 4
        bne $t0, $t1, output
        












