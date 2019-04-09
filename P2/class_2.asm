.data
temp: .word 0:64
res: .word 0:64
space: .asciiz " "
enter: .asciiz "\n"
.text
main: li $v0, 5
      syscall
      move $a1, $v0 # $a1 = n
      li $v0, 5
      syscall
      move $a2, $v0 # $a2 = m
      
      move $t0, $0 # $t0 = i
      move $t1, $0 # $t1 = j
      move $s0, $0 # 当前赋值行
      move $s1, $0 # 当前赋值列
      input: #为一行矩阵赋值
      mult $s0, $a2
      mflo $s2 # 当前行*总列数
      add $s2, $s2, $s1 # 当前行*总列数 + 当前列
      sll $s2, $s2, 2  # *4
      li $v0, 5
      syscall 
      sw $v0, temp($s2)
      addi $s1, $s1, 1
      bne $s1, $a2, input
      #为下一行矩阵赋值
      move $s1, $0 # 当前列清零
      addi $s0, $s0, 1 # 当前行+1
      bne $s0, $a2, input
      
      beq $a1, $0, end
power:
     move $t0, $0 # i = 0
     begin:
     sqrt: move $t2, $0 # $t2 = i
           move $t3, $0 # $t3 = j
           move $t4, $0 # $t4 = k
           for_3: move $t3, $0 # $t3 = j
           for_2: mult $t2, $a2
                  mflo $s0
                  add $s0, $s0, $t3
                  sll $s0, $s0, 2
                  sw $0, res($s0) #res[i][j] = 0
                  move $t4, $0 # $t4 = k
           for_1: mult $t2, $a2
                  mflo $s0 # 当前行*总列数
                  add $s0, $s0, $t3
                  sll $s0, $s0, 2
                  lw $s1, res($s0) # $s1 = res[i][j]
                  mult $t2, $a2
                  mflo $s2  
                  add $s2, $s2, $t4
                  sll $s2, $s2, 2
                  lw $s3, temp($s2) #
                  mult $t4, $a2
                  mflo $s2 
                  add $s2, $s2, $t3
                  sll $s2, $s2, 2
                  lw $s4, temp($s2) #
                  mult $s3, $s4 
                  mflo $s3 #temp[i][k]*temp[k][j]
                  add $s1, $s1, $s3
                  sw $s1, res($s0)
                  addi $t4, $t4, 1 # k++
                  bne $t4, $a2, for_1
                  
                  add $t3, $t3, 1
                  bne $t3, $a2, for_2
                  
                  add $t2, $t2, 1
                  bne $t2, $a2, for_3
       
       replace: move $t2, $0 # i = 0 
                move $t3, $0 # j = 0
                
       for__1:  mult $t2, $a2
                mflo $s0
                add $s0, $s0, $t3
                sll $s0, $s0, 2
                lw $s1, res($s0)
                sw $s1, temp($s0)
                addi $t3, $t3, 1 # j++
                bne $t3, $a2, for__1
                addi $t2, $t2, 1 # i++
                move $t3, $0
                bne $t2, $a2, for__1         
 
     addi $t0, $t0, 1 # i++
     bne $t0, $a1, begin 
end:
       move $s0, $0 #当前行
       move $s1, $0 #当前列
output: mult $s0, $a2
      mflo $s2 # 当前行*总列数
      add $s2, $s2, $s1 # 当前行*总列数 + 当前列
      sll $s2, $s2, 2  # *4
      lw $a0, temp($s2) #
      li $v0, 1
      syscall 
      la $a0, space
      li $v0, 4
      syscall #输出空格
      addi $s1, $s1, 1
      bne $s1, $a2, output
      #为下一行矩阵赋值
      move $s1, $0 # 当前列清零
      addi $s0, $s0, 1 # 当前行+1
      la $a0, enter
      li $v0, 4
      syscall
      bne $s0, $a2, output
      
