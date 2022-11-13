extrn calSum:far ;标识远端程序  不写 将会汇编错误
extrn outRes:far
;换行宏
next macro
             mov dx,offset LINE
             mov ah,09h
             int 21h
endm
data segment
        LINE db 0dh,0ah,'$'        ;换行
data ends
stack segment
stack ends
code segment
              assume cs:code,ds:data,ss:stack
        start:
              mov    ax,data                         ;载入数据
              mov    ds,ax
              call   far ptr calSum
              call   far ptr outRes
              next
              mov    ah,4CH
              int    21H
code ends
end start