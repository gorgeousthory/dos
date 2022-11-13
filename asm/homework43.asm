public outRes;声明为远端函数
data segment
       num  db 0,0,0,0       ;数组用于存放结果并输出
data ends
stack segment
stack ends
code segment
              assume cs:code,ds:data,ss:stack
       start:                                       ;循环除以10得到十进制结果并存入数组中
              mov    ax,data                        ;载入数据
              mov    ds,ax
outRes proc
              lea    si,num                         ;把 si 赋值为数组的起始地址
              mov    dx,0                           ;清除余数
              mov    bx,10                          ;除数
              mov    cx,4                           ;循环4次
       p1:    
              div    bx                             ;除法
              mov    num[si],dl                     ;把余数存到 num 数组
              mov    dx,0                           ;清除余数
              inc    si                             ;指针自增
              loop   p1

       ;按数组倒序输出结果
       p2:    
              dec    si                             ;数组自减
              mov    al,'0'                         ;ascii码预备
              add    al,num[si]
              mov    dl,al                          ;把数组中的每一个数放到 dl 输出
              mov    ah,02h
              int    21h
              cmp    si,0                           ;指针为0时结束循环
              jnz    p2
              retf
outRes endp
code ends
end start