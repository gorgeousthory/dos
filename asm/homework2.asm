;作业2-九九乘法表的输出（含过程）
data segment
    PR   db 1 dup(0),'*',1 dup(0),'=', 2 dup(0),' ','$'    ;存储结果
    LINE db 0dh,0ah,'$'                                    ;换行
    IPP  dw 0000h                                          ;IP
data ends
stack segment
          db 20 dup(0)
stack ends
code segment
           assume cs:code,ds:data,ss:stack
    start: 
           mov    ax,data
           mov    ds,ax
           mov    cx,0009h                    ;循环九次，控制输出
    
    ;行循环
    row:   
           mov    dh,0ah
           sub    dh,cl                       ;dh存储该行最大列数
           mov    dl,01h                      ;dl存储当前列数
    ;列循环
    col:   
           mov    al,dh                       ;最大列数也是被乘数
           and    ax,00ffh                    ;清空高位
           cmp    dl,dh                       ;dl大于dh则跳转至next
           ja     next
           push   dx                          ;列数压栈
           push   cx                          ;行数压栈
           push   ax                          ;被乘数压栈
           push   dx                          ;乘数压栈
           mov    al,dh                       ;进行乘法
           mul    dl
           push   ax                          ;结果压栈
           call   output                      ;调用输出过程
           pop    cx                          ;行数弹栈
           pop    dx                          ;列数弹栈
           inc    dl                          ;当前列数自增，进入下次循环
           jmp    col
    ;换行
    next:  
           mov    dx,offset LINE
           mov    ah,09h
           int    21h
           loop   row                         ;开始输出下一行，直到cx为0时结束循环
           mov    ah,4ch
           int    21h

    ;输出结果过程
output proc
           pop    IPP                         ;主函数地址弹栈
           pop    dx                          ;结果弹栈
           mov    ax,dx
           mov    bl,0ah                      ;转换为10进制
           div    bl                          ;除后 商为十位，存在al，余数为个位，存在ah
           add    ax,3030h                    ;加上对应的ascii码（'0':30h）
           mov    PR+4,al
           mov    PR+5,ah
           pop    ax                          ;乘数弹栈
           and    al,0fh                      ;清空高位
           add    al,30h
           mov    PR,al
           pop    ax                          ;被乘数弹栈
           and    al,0fh
           add    al,30h
           mov    PR+2,al
    ;输出结果
           mov    dx,offset PR
           mov    ah,09h
           int    21h
           push   IPP                         ;主函数地址压栈
           ret
output endp
code ends
end start