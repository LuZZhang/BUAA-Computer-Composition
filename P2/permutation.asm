.data
symbol:.word 0 : 7
array: .word 0 : 7
enter:.asciiz"\n"
space:.asciiz" "
.text 
main: li $v0, 5
   syscall
   move $a1, $v0  # a1 = n
   move $t0, $0   #i = 0
   move $t2, $0   #index = 0
   jal per
   
   li $v0, 10   #结束
   syscall
per:  sw $ra, 0($sp)
      addi $sp, $sp, -4    #存地址
      sw $t0, 0($sp)
      addi $sp, $sp, -4    #存 i
     bne $t2, $a1, work_i  #index != n 跳转
     li $t5, 0   #j = 0
     output: sll $t1, $t5, 2  # t1 = 4 * j
        lw $a0, array($t1) # a0 = array[j]
        li $v0, 1
        syscall   #输出数字
        la $a0, space
        li $v0, 4
        syscall   #输出字符串
        addi $t5, $t5, 1     #j++
        
        bne $t5, $a1, output # j < n 时跳转
     
        la $a0, enter  #输出换行符
        li $v0, 4
        syscall
        
        jr $ra  #return
                
work_i: li $t0, 0 # i = 0
work:
      
      sll $t4, $t0, 2  # t4 = 4 * i
      lw $t3, symbol($t4) #t3 = symol[i]
      bne $t3, $0, if_end
      sll $t4, $t2, 2  # t4 = 4 * index
      addi $t3, $t0, 1  # t3 = i + 1
      sw $t3, array($t4)  #array[index] = i + 1
      sll $t4, $t0, 2 # t4 = 4 * i
      li $t3, 1        # t3 = 1
      sw $t3, symbol($t4)  # symbol[i] = 1
      # per(index+1);
      addi $t2, $t2, 1  #index = index +1
      jal per
      #addi $sp,$sp,4
     # lw $t0,4($sp)    #取i
      sll $t4, $t0, 2  # t4 = 4 * i
      sw $0, symbol($t4)  # symbol[i] = 0
if_end: addi $t0, $t0, 1  #i ++
     bne $t0, $a1, work
     
     addi $sp,$sp,4
     lw $t0,0($sp)    #取i
     addi $sp,$sp,4
     lw $ra,0($sp)    #取地址
     addi $t2, $t2, -1
     
     jr $ra
     
       
