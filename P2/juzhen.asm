.data
data1: .word 0:64
data2: .word 0:64
data3: .word 0:64
space:.asciiz  " "  
enter:.asciiz "\n"
.text
  li $v0, 5
  syscall    #�������n
  move $a1, $v0  #a1=n
  move $t0, $a1  #t0��������
  move $t1, $a1  #t1��������
  move $s0, $0   #��ǰ��ֵ����
  move $s1, $0   #��ǰ��ֵ����
  move $t2, $0   #Ҫ����ֵ
  
loop1:  #Ϊһ�о���ֵ
  mult $s0, $t1   #��ǰ��*������
  mflo $s2        
  add $s2, $s2, $s1 #�ټ��ϵ�ǰ��ֵ���� �õ�$s2=�ھ����еĵڼ�����
  sll $s2, $s2, 2   #$s2 * 4, �õ���ַƫ��
  li $v0, 5
  syscall
  move $t2, $v0    #t2ΪҪ����ֵ
  sw $t2, data1($s2) #��
  addi $s1, $s1, 1
  bne $s1, $t1, loop1  #����ֵ��û������������תloop
  
  #Ȼ��Ϊ��һ�о���ֵ
  move $s1, $0       #����ֵ������
  addi $s0, $s0, 1   #����ֵ�У�1
  bne $s0, $t0, loop1 #����ֵ��û����������ת
  
#�ڶ������� B ��ֵ
  move $s0, $0   #��ǰ��ֵ����
  move $s1, $0   #��ǰ��ֵ����
  move $t2, $0   #Ҫ����ֵ
 
 loop2:  #Ϊһ�о���ֵ
  mult $s0, $t1   #��ǰ��*������
  mflo $s2        
  add $s2, $s2, $s1 #�õ�$s2=�ھ����еĵڼ�����
  sll $s2, $s2, 2   #$s2 * 4, �õ���ַƫ��
  li $v0, 5
  syscall
  move $t2, $v0    #t2ΪҪ����ֵ
  sw $t2, data2($s2) #��
  addi $s1, $s1, 1
  bne $s1, $t1, loop2  #����ֵ��û������������תloop
  
  #Ȼ��Ϊ��һ�о���ֵ
  move $s1, $0       #����ֵ������
  addi $s0, $s0, 1   #����ֵ�У�1
  bne $s0, $t0, loop2 #����ֵ��û����������ת
  
#���������� a ��ֵ
  move $s0, $0   #��ǰ��ֵ����
  move $s1, $0   #��ǰ��ֵ����
  move $t2, $0   #Ҫ����ֵ
  
 loop3:  #Ϊһ�о���ֵ
  mult $s0, $t1   #��ǰ��*������
  mflo $s2        
  add $s2, $s2, $s1 #�õ�$s2=�ھ����еĵڼ�����
  sll $s2, $s2, 2   #$s2 * 4, �õ���ַƫ��
  move $t2, $0      # Ҫ��ֵ����
  mult $s0, $t1
  mflo $t5
  sll $t5, $t5, 2    #A �ĵ�һ���������ĵ�ַƫ��
  sll $s3, $s1, 2    #��ǰ��ֵ�� * 4  B�ĵ�һ��������
  sll $s4, $t1, 2    #������ * 4
  addi $s6, $s0, 1
  mult $s6, $s4
  mflo $s6
    loop: #�õ�$t2
      lw $t3, data1($t5)  #ȡ����һ��������Ai
      lw $t4, data2($s3)  #ȡ���ڶ���������Bj
      mult $t3, $t4
      mflo $t3  #�õ���˽��
      add $t2, $t2, $t3
      addi $t5, $t5, 4
      add $s3, $s3, $s4 
      bne $t5, $s6, loop  #�� A û��ȡ�����ұ�ʱ��ת
      
  sw $t2, data3($s2) #��
  addi $s1, $s1, 1
  bne $s1, $t1, loop3  #����ֵ��û������������תloop
  
  #Ȼ��Ϊ��һ�о���ֵ
  move $s1, $0       #����ֵ������
  addi $s0, $s0, 1   #����ֵ�У�1
  bne $s0, $t0, loop3 #����ֵ��û����������ת
  
  ####���
  move $s0, $0   #��ǰ�������
  move $s1, $0   #��ǰ�������
  move $t2, $0   #Ҫ�����ֵ
 looop:
  mult $s0, $t1   #��ǰ��*������
  mflo $s2        
  add $s2, $s2, $s1 #�õ�$s2=�ھ����еĵڼ�����
  sll $s2, $s2, 2   #$s2 * 4, �õ���ַƫ��
  lw $a0, data3($s2) #��Ҫ�����ֵȡ��
  li $v0, 1
  syscall   #��� ����a
  la $a0, space
  li $v0, 4
  syscall
  addi $s1, $s1, 1
  bne $s1, $t1, looop  #����ֵ��û������������תlooop
  
  #Ȼ����һ�о������
  move $s1, $0       #����ֵ������
  addi $s0, $s0, 1   #����ֵ�У�1
  la $a0, enter
  li $v0, 4
  syscall
  bne $s0, $t0, looop #����ֵ��û����������ת


