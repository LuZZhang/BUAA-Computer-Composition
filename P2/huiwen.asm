.data
s: .byte 20
.text
   li $v0, 5
   syscall
   move $a1, $v0  #$a1 = n
   move $t0, $0   # t0 = i
   li $s0, 0    #judge = 0
input: li $v0, 12  
       syscall
       move $a2, $v0   #a2 = s[i]
       sb $a2, s($t0)  #s[i] = a2
       addi $t0, $t0, 1
       bne $t0, $a1, input
       
       move $t0, $0   # i = 0
       addi $t1, $a1, -1  # j = n - 1
       li $t2, 2          #
       divu $a1, $t2      #
       mflo $t2           #get [n/2]
       addi $t5, $t2, -1
judge: lb $t3, s($t0)    # t3 = s[i]
       lb $t4, s($t1)    # t4 = s[j]
       bne $t3, $t4, jup  # if t3 != t4 , jump out 
       beq $t0, $t5, juup # if i == [n/2]-1
       j juuup
       juup: li $s0, 1    #judge = 1
       juuup:
       addi $t0, $t0, 1   #i + +
       addi $t1, $t1, -1  #j - -
       bne $t0, $t2, judge 
       jup:
output: move $a0, $s0   #judge
        li $v0, 1
        syscall
        
       
       
       
       