.data
num:.word 0:100
space:.asciiz " "
.text
   li $v0, 5
   syscall 
   move $a1, $v0  # $a1 = n 输入n
   move $t0, $0 #i = 0
   move $t1, $0 #j = 0
   
   
input: sll $t2, $t0, 2  # t2 = 4 * i
       li $v0, 5
       syscall #输入num[i]
       sw $v0, num($t2)
       addi $t0, $t0, 1  # i ++
       bne $t0, $a1, input
       
       move $t0, $0  #i = 0
       addi $a2, $a1, -1 # a2 = n-1
       
       move $t6, $0    #savei
sort1: move $t1,$t0  # j = i
       li $t4, 100001 #min 
       sort2: sll $t5, $t1, 2 # t5 = 4*j
              lw $t3, num($t5) #t3 = num[j]
              sub $t5, $t4, $t3 # t5 = min - num [j]
              bgtz $t5, swap1
              j lop
              swap1: move $t4, $t3 #min = num [j]
                     move $t6, $t1 # savei = j
              lop:
              addi $t1, $t1, 1 # j++
              bne $t1, $a1, sort2
        sll $t7, $t6, 2 #t7= 4*savei
        lw $t3, num($t7)  #t3 = min
        sll $t2, $t0, 2 # t2 = 4*i
        lw $t4, num($t2)  #t4 = num[i]
        sw $t3, num($t2)
        sw $t4, num($t7)
        addi $t0, $t0, 1
        bne $t0, $a1, sort1
        
        move $t0, $0  #i = 0
output: sll $t1, $t0, 2  #j = 4 * i
        lw $a0, num($t1)  # #a0 = num[i]
        li $v0, 1
        syscall #输出整数
        la $a0, space
        li $v0, 4
        syscall
        addi $t0, $t0, 1
        bne $t0, $a1, output
       
