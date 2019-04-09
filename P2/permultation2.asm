.data
array: .word 0 : 7
symbol: .word 0 : 7
space: .asciiz " "
enter: .asciiz "\n"
.text
main: li $v0, 5
      syscall
      move $a1, $v0  # 输入 n = a1
      #初始化
      move $t0, $0 # i = 0
      move $a2, $0 # index = 0
      move $t1, $0 # j = 0
      
      jal per
      
      li $v0, 10
      syscall #结束
per: sw $ra, 0($sp)  # 存地址
     addi $sp, $sp, -4
     sw $t0, 0($sp)  #存 i
     addi $sp, $sp, -4
     
     bne $a2, $a1, work_i
     move $t1, $0 #j = 0
output: sll $t2, $t1, 2 #j * 4
        lw $a0, array($t2)
        li $v0, 1
        syscall # 输出
        la $a0, space
        li $v0, 4
        syscall # 输出空格
        addi $t1, $t1, 1
        bne $t1, $a1, output  
        la $a0, enter
        li $v0, 4
        syscall #输出空格
        
        jr $ra
work_i: move $t0, $0 # i = 0
work:   sll $t2, $t0,2 # t2 = 4 * i
        lw $t3, symbol($t2) # t3 = symbol[i]
        bne $t3, $0, if_end
        sll $t3, $a2, 2 # t3 = 4 * index
        addi $t4, $t0, 1
        sw $t4, array($t3)
        li $t4, 1
        sw $t4, symbol($t2)
        addi $a2, $a2, 1 #index++
        jal per
        sll $t2, $t0, 2 # t2 = 4 * i
        sw $0, symbol($t2)
if_end: addi $t0, $t0, 1
        bne $t0, $a1, work     
        
        addi $sp, $sp, 4
        lw $t0, 0($sp)
        addi $sp, $sp, 4
        lw $ra, 0($sp)
        
        addi $a2, $a2, -1  #index --
        
        jr $ra
        
        
        
        
        
        