.data
data1: .word 0:64
data2: .word 0:64
data3: .word 0:64
space:.asciiz  " "  
enter:.asciiz "\n"
.text
  li $v0, 5
  syscall    #输入阶数n
  move $a1, $v0  #a1=n
  move $t0, $a1  #t0是总行数
  move $t1, $a1  #t1是总列数
  move $s0, $0   #当前赋值行数
  move $s1, $0   #当前赋值列数
  move $t2, $0   #要赋的值
  
loop1:  #为一行矩阵赋值
  mult $s0, $t1   #当前行*总列数
  mflo $s2        
  add $s2, $s2, $s1 #再加上当前赋值列数 得到$s2=在矩阵中的第几个数
  sll $s2, $s2, 2   #$s2 * 4, 得到地址偏移
  li $v0, 5
  syscall
  move $t2, $v0    #t2为要赋的值
  sw $t2, data1($s2) #存
  addi $s1, $s1, 1
  bne $s1, $t1, loop1  #当赋值列没到总列数，跳转loop
  
  #然后为下一行矩阵赋值
  move $s1, $0       #被赋值列清零
  addi $s0, $s0, 1   #被赋值行＋1
  bne $s0, $t0, loop1 #当赋值行没到总行数跳转
  
#第二个矩阵 B 赋值
  move $s0, $0   #当前赋值行数
  move $s1, $0   #当前赋值列数
  move $t2, $0   #要赋的值
 
 loop2:  #为一行矩阵赋值
  mult $s0, $t1   #当前行*总列数
  mflo $s2        
  add $s2, $s2, $s1 #得到$s2=在矩阵中的第几个数
  sll $s2, $s2, 2   #$s2 * 4, 得到地址偏移
  li $v0, 5
  syscall
  move $t2, $v0    #t2为要赋的值
  sw $t2, data2($s2) #存
  addi $s1, $s1, 1
  bne $s1, $t1, loop2  #当赋值列没到总列数，跳转loop
  
  #然后为下一行矩阵赋值
  move $s1, $0       #被赋值列清零
  addi $s0, $s0, 1   #被赋值行＋1
  bne $s0, $t0, loop2 #当赋值行没到总行数跳转
  
#第三个矩阵 a 赋值
  move $s0, $0   #当前赋值行数
  move $s1, $0   #当前赋值列数
  move $t2, $0   #要赋的值
  
 loop3:  #为一行矩阵赋值
  mult $s0, $t1   #当前行*总列数
  mflo $s2        
  add $s2, $s2, $s1 #得到$s2=在矩阵中的第几个数
  sll $s2, $s2, 2   #$s2 * 4, 得到地址偏移
  move $t2, $0      # 要赋值的数
  mult $s0, $t1
  mflo $t5
  sll $t5, $t5, 2    #A 的第一个操作数的地址偏移
  sll $s3, $s1, 2    #当前赋值列 * 4  B的第一个操作数
  sll $s4, $t1, 2    #总列数 * 4
  addi $s6, $s0, 1
  mult $s6, $s4
  mflo $s6
    loop: #得到$t2
      lw $t3, data1($t5)  #取出第一个操作数Ai
      lw $t4, data2($s3)  #取出第二个操作数Bj
      mult $t3, $t4
      mflo $t3  #得到相乘结果
      add $t2, $t2, $t3
      addi $t5, $t5, 4
      add $s3, $s3, $s4 
      bne $t5, $s6, loop  #当 A 没有取到最右边时跳转
      
  sw $t2, data3($s2) #存
  addi $s1, $s1, 1
  bne $s1, $t1, loop3  #当赋值列没到总列数，跳转loop
  
  #然后为下一行矩阵赋值
  move $s1, $0       #被赋值列清零
  addi $s0, $s0, 1   #被赋值行＋1
  bne $s0, $t0, loop3 #当赋值行没到总行数跳转
  
  ####输出
  move $s0, $0   #当前输出行数
  move $s1, $0   #当前输出列数
  move $t2, $0   #要输出的值
 looop:
  mult $s0, $t1   #当前行*总列数
  mflo $s2        
  add $s2, $s2, $s1 #得到$s2=在矩阵中的第几个数
  sll $s2, $s2, 2   #$s2 * 4, 得到地址偏移
  lw $a0, data3($s2) #将要输出的值取出
  li $v0, 1
  syscall   #输出 数字a
  la $a0, space
  li $v0, 4
  syscall
  addi $s1, $s1, 1
  bne $s1, $t1, looop  #当赋值列没到总列数，跳转looop
  
  #然后下一行矩阵输出
  move $s1, $0       #被赋值列清零
  addi $s0, $s0, 1   #被赋值行＋1
  la $a0, enter
  li $v0, 4
  syscall
  bne $s0, $t0, looop #当赋值行没到总行数跳转


