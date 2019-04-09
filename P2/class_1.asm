.data
res: .byte 0:26
num: .word 0:26
space: .asciiz " "
enter: .asciiz "\n"
.text
main: li $v0, 5
      syscall
      move $a1, $v0 #$a1 = n
      #³õÊ¼»¯
      move $t0, $0
      move $t1, $0
      move $s0, $0 #judge
      move $s1, $0 #pan
      for_1: li $v0, 12 
             syscall
             move $t2, $v0 # $t2 = c
             #if(judge = 0)
             bne $s0, $0, else
             sb $t2, res($0)
             addi $s0, $s0, 1 #judge =1
             sw $s0, num($0) 
             j if_end           
             else: li $s1, 0    #pan = 0
                   move $t1, $0 #j = 0
                   for_2: lb $t3, res($t1) # $t3 = res[j]
                          bne $t3, $t2, end
                          sll $t3, $t1, 2 # $t3 = 4  * j
                          lw $t4, num($t3) # t4 = num[j]
                          addi $t4, $t4, 1 #
                          sw $t4, num($t3)
                          li $s1, 1 #pan = 1
                          end:
                          addi $t1, $t1, 1
                          bne $t1, $s0, for_2
                    bne $s1, $0, if_end
                          #pan = 0
                          sb $t2, res($s0) #res[jusge) = c
                          sll $t3, $s0, 2
                          li $t4, 1
                          sw $t4, num($t3) #num[judge] = 1
                          addi $s0, $s0, 1 #judge ++
                    if_end:
             addi $t0, $t0, 1
             bne $t0, $a1, for_1      
        
             move $t0, $0
             for_3: #addi $t0, $t0, 1
                    lb $a0, res($t0) # t1 = res[i]
                    li $v0, 11
                    syscall # Êä³öc
                    la $a0, space
                    li $v0, 4
                    syscall
                    sll $t1,$t0, 2
                    lw $a0, num($t1)
                    li $v0, 1
                    syscall
                    la $a0, enter
                    li $v0, 4
                    syscall
                    addi $t0, $t0, 1
                    bne $t0, $s0, for_3
             
             
             
             
             
             
      
