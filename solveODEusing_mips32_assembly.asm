                # java -jar Mars4_5.jar nc 2001254.asm pa y(0) h numberOfSteps
                # java -jar Mars4_5.jar v0 0x10010000-0x10010000 np 2001254.asm pa y(0) h numberOfSteps
                            .text 
                            
 .globl main                         
 main :                          lw $t0,0($a1)         #loading inputs values from memory from where it's been stored using the cmd line above
                                 lw $t1,4($a1)
                                 lw $t2,8($a1)
 
                                 lb $s0,0($t0)
                                 addi $s0,$s0,-48
                                 lb $s1,0($t1)
                                 addi $s1,$s1,-48
                                 lb $s2,0($t2)
                                 addi $s2,$s2,-48     # finished getting the values of the inputs 
                             
                               
                                 addi $a0 , $s0 , 0
                                 addi $a1 , $s1 , 0
                                 addi $a2 , $s2 ,0
                
              ####################################################                                                                                                                    
                                 jal euler_fn
                                 
                                 lui $t0 , 4097       
                                 sw  $v0 , 0($t0)
                                 j   Exit                              
   
    
 
     euler_fn :                   addi $sp , $sp , -16     #storing the values of s0 s1 s2 (though this doesn't actually matter in this code)
                                  sw   $s0 , 0($sp)
                                  sw   $s1 , 4($sp)
                                  sw   $s2 , 8($sp)
                                  sw   $ra , 12($sp)                           
                                  addi $s0 , $a0 , 0
                                  addi $s1 , $a1 , 0
                                  addi $s2 , $a2 ,0   
                                  beq  $s2 , $0 , End_Euler                         
                                  add  $a2 , $zero , $zero   #Entering the outer do while loop of Euler func a2 is i of this loop
               loop_2 :           add  $a0 , $a2 , $zero       
                                  add  $a1 , $s1 , $zero
                                  jal  multi                 # i*h
                                  add  $a3 , $v0 , $zero     # x = i*h
                                  addi $a0 , $a3 , 0
                                  addi $a1 , $a3 , 0
                                  jal  multi                # x^2
                                  addi $a0 , $v0 , 0
                                  addi $a1 , $0 , 157
                                  jal  multi                # 157*x^2
                                  addi $v1 , $v0 , 0        # y' = 157*x^2
                                  addi $a0 , $a3 , 0
                                  addi $a1 , $0 , 78
                                  jal  multi                # x*78
                                  sub  $v1 , $v1 ,$v0       # y' = 157*x^2 - x*78
                                  addi $a0 , $s0 , 0
                                  addi $a1 , $s0 , 0
                                  jal  multi                # y(n)*y(n)
                                  addi $t6 , $v0 , 0
                                  addi $a0 , $v0 , 0        
                                  addi $a1 , $s0 , 0
                                  jal  multi                # y(n)*y(n)*y(n)
                                  addi $a0 , $v0 , 0
                                  addi $a1 , $0 , 408
                                  jal  multi                 # 408*y(n)*y(n)*y(n)
                                  add  $v1 , $v1 , $v0       # y' = 157*x^2 - x*78 + 408*y(n)*y(n)*y(n)
                                  addi $a0 , $t6 , 0
                                  addi $a1 , $zero , 34
                                  jal multi                  # 34 * y(n)*y(n)
                                  sub $v1 , $v1 , $v0        # y' = 157*x^2 - x*78 + 408*y(n)*y(n)*y(n) - 34 * y(n)*y(n)
                                  addi $a0 , $s0 , 0
                                  addi $a1 , $zero , 28
                                  jal  multi                # y(n)*28
                                  sub $v1 , $v1 , $v0       # y' = 157*x^2 - x*78 + 408*y(n)*y(n)*y(n) - 34 * y(n)*y(n) - y(n)*28
                                  addi $v1 , $v1 , -16      # y' = 157*x^2 - x*78 + 408*y(n)*y(n)*y(n) - 34 * y(n)*y(n) - y(n)*28 -16
                                  addi $a0 , $v1 , 0    
                                  addi $a1 , $s1 , 0
                                  jal  multi                # h*y'
                                  add  $s0 , $s0 , $v0      # y = y + h*y'
                                  addi $a2 , $a2 , 1        
                                  bne  $a2 , $s2 , loop_2   #if i != h it will loop (if course it will go from 0 to h-1)
             End_Euler :          addi $v0 , $s0 , 0        # $v0 = y
                                  lw   $s0 , 0($sp)
                                  lw   $s1 , 4($sp)
                                  lw   $s2 , 8($sp)
                                  lw   $ra , 12($sp)
                                  addi $sp , $sp , 16
                                  jr   $ra
                                  
                                  
   
     multi :                       addi $t0 , $zero , 0                # func. to multiply x*n : a0*a1 using this idea: xn = x(2^i) + x(n-2^i)
                                   addi $t2 , $0 , 1                   
                                   slt $t1 , $a0 , $zero               # we turn x and n to +ve if they're not already       
                                   bne $t1 , $zero , Invert_x          
        n_sign :                   slt $t1 , $a1 , $zero
                                   bne $t1 , $zero , Invert_n
        comparison :               slt $t1 , $a0 , $a1                 #we check to see which one is smaller and the smaller one will be n
                                   bne $t1 , $zero , replace_arguments
        backTo :                   beq $a1 , $zero , Zero              #if one of them is zero result will be 0
                                   beq $a1 , $t2 , itself              #if one of them is 1 result will be the other

                                   add  $t1 , $zero , $zero            # t1 is i for this loop
                                   addi $t2 , $zero , 1                #we enter this for loop to get the closest 2^i value to n 
       For :                       sll  $t2 , $t2 , 1
                                   slt  $t3 , $a1 , $t2
                                   addi $t1 , $t1 , 1
                                   beq  $t3 , $zero , greatOrEqu      #once we reach it (n >= 2^i) we goto greatOrEqu
                                   addi $t3 , $zero , 31
                                   slt  $t7 , $t3 , $t1
                                   beq  $t7 , $zero , For
                                   j    Exit_func   
                                            
      Zero :                       add $v0 , $zero , $zero                         
                                   jr  $ra              
                                                     
      Invert_n :                   sub $a1 , $0 , $a1
                                   addi $t0 , $t0 , 1
                                   j    comparison
                                   
      Invert_x :                   sub $a0 , $0 , $a0
                                   addi $t0 , $t0 , -1
                                   j    n_sign
                                   
      itself :                     add $v0 , $a0 , $zero
                                   j   Exit_func                                                    
                                
                                   
      greatOrEqu :                 sub $t4 , $a1 , $t2             #t4 = n - 2^i
                                   add $t5 , $zero , $zero         #t5 is i for this loop (this loop shifts a0 number of times = t1)
                                   add $v0 , $a0 , $zero
          shifting  :              sll $v0 , $v0 , 1  
                                   addi $t5 , $t5 , 1
                                   beq $t5 , $t1 , addXToResultDiffTimes     #once we reach result = x*(2^i) , we add 
                                   j   shifting                              
                                                       
    addXToResultDiffTimes :        add $t5 , $zero , $zero               #add x to result (n-2^i) times                           
    Loop :                         beq $t5 , $t4 , Exit_func
                                   add $v0 , $v0 , $a0                                        
                                   addi $t5 , $t5 , 1                                                                                                    
                                   j   Loop  
                                                                                            
   replace_arguments:              addi $t3 , $a0 , 0                                                   
                                   addi $a0 , $a1 , 0
                                   addi $a1 , $t3 , 0              
                                   j    backTo
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
   Exit_func :                     beq $t0 , $zero , Exit_awy       #at the end of execution if t0 = 0 so result +ve else -ve    
                                   nor $v0 , $v0 , $zero                            
                                   addi $v0 , $v0 , 1
   Exit_awy :                      jr  $ra                                                                                                                
                                                                                                                                                    

                                                                     
    Exit :                         nop
