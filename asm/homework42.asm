public calSum;声明为远端函数
data segment
data ends
stack segment
stack ends
code segment
              assume cs:code,ds:data,ss:stack
       start: 
calSum proc
              mov    ax,0                           ;累加和，初始化为0
              mov    dx,1                           ;加数，从1开始
              mov    cx,100                         ;设置循环100次
              mov    cx,100                         ;设置循环100次
       s:     add    ax,dx                          ;和加加数
              inc    dx                             ;加数自增
              loop   s                              ;继续循环
              retf
calSum endp
code ends
end start