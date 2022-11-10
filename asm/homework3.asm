;作业3-输入并输出年月日（过程调用练习）
data segment
    DATE db 2 dup(0),'-',2 dup(0),'-', 2 dup(0),'$'    ;存储结果
    TIP  db 'WHAT IS THE DATE(MM/DD/YY)?','$'          ;输入提示字符串
    LINE db 0dh,0ah,'$'                                ;换行富
    IPP  dw 0000h                                      ;IP
data ends
stack segment
          db 20 dup(0)
stack ends
code segment
               assume cs:code,ds:data,ss:stack
    start:     
               mov    ax,data
               mov    ds,ax
    ;输出输入提示
               mov    dx,offset TIP
               mov    ah,9h
               int    21h
    ;输出响铃符
               mov    dx,07h
               mov    ah,2h
               int    21h
               mov    cx,6h
    ;获取输入日期
    getDate:   
               call   GetNum
               pop    ax
    ;根据循环次数确定输入信息，相当于if-else if-else语句
               cmp    cx,05h
               jae    fillMonth
               cmp    cx,03h
               jae    fillDay
               cmp    cx,01h
               jae    fillYear
    fillMonth: 
               mov    bx,9
               sub    bx,cx
               mov    DATE[bx],al
               loop   getDate
    fillDay:   
               mov    bx,10
               sub    bx,cx
               mov    DATE[bx],al
               loop   getDate
    fillYear:  
               mov    bx,2
               sub    bx,cx
               mov    DATE[bx],al
               loop   getDate
    ;结束输入循环，输出结果
               call   OutPutLine                  ;输出换行符
               call   DispDate                    ;调用日期输出过程
               call   OutPutLine                  ;输出换行符
               mov    ah,4ch                      ;结束程序
               int    21h

    
GetNum proc                                       ;输入数字过程定义
               pop    IPP                         ;主函数地址弹栈
    input:     
               mov    ah,1h                       ;输入字符
               int    21h
               cmp    al,'0'                      ;验证输入合法
               jb     input
               cmp    al,'9'
               ja     input
               push   ax
               push   IPP                         ;主函数地址压栈
               ret
GetNum endp
DispDate proc
               mov    bx,0
    L1:        mov    al,Date[bx]                 ;输出年份和字符
               mov    dx,ax
               mov    ah,02h
               int    21h
               inc    bx
               cmp    bx,3
               jb     L1
               call   DispDate2
               ret
DispDate endp
DispDate2 proc
    L2:        mov    al,Date[bx]                 ;输出月份和字符
               mov    dx,ax
               mov    ah,02h
               int    21h
               inc    bx
               cmp    bx,6
               jb     L2
               call   DispDate3
               ret
DispDate2 endp
DispDate3 proc
    L3:        mov    al,Date[bx]                 ;输出日份
               mov    dx,ax
               mov    ah,02h
               int    21h
               inc    bx
               cmp    bx,8
               jb     L3
               ret
DispDate3 endp
OutPutLine proc                                   ;输出换行符过程定义
               pop    IPP                         ;主函数地址弹栈
               mov    dx,offset LINE              ;输出换行符
               mov    ah,09h
               int    21h
               push   IPP                         ;主函数地址压栈
               ret
OutPutLine endp
code ends
end start