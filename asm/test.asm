;作业2-九九乘法表的输出（含过程）
;换行宏
next macro
         mov dx,offset LINE
         mov ah,09h
         int 21h
endm
data segment
    PR   db 'helloworld','$'    ;存储结果
    LINE db 0dh,0ah,'$'         ;换行
    IPP  dw 0000h               ;IP
data ends
stack segment
          db 20 dup(0)
stack ends
code segment
           assume cs:code,ds:data,ss:stack
    start: 
           mov    ax,data
           mov    ds,ax
           call   output
           mov    ah,4ch
           int    21h

    ;输出结果过程
output proc
           mov    dx,offset PR
           mov    ah,09h
           int    21h
           next
           next
           ret
output endp
code ends
end start