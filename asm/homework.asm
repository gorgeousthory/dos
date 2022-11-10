;作业1：从1累加至100并输出结果
DATA SEGMENT
	num  db 0,0,0,0    	;数组用于存放结果并输出
	LINE db 0dh,0ah,'$'	;换行
DATA ENDS

CODE SEGMENT
	      ASSUME CS:CODE,DS:DATA
	start:
		  mov    ax,data			;载入数据
          mov    ds,ax
	;累加过程
	      mov    ax,0           	;累加和，初始化为0
	      mov    dx,1           	;加数，从1开始
	      mov    cx,100         	;设置循环100次
	;开始循环(loop循环指令实现)
	      mov    cx,100         	;设置循环100次
	s:    add    ax,dx          	;和加加数
	      inc    dx             	;加数自增
	      loop   s              	;继续循环

	;开始循环(条件跳转指令实现)
	; s:    add    ax,dx          	;和加加数
	;       inc    dx             	;加数自增
	;       cmp    dx,101         	;条件判断，当加数等于101时跳出循环
	;       jnz    s              	;条件跳转

	;输出结果，此时ax的值应是13bah
	      lea    si,num         	;把 si 赋值为数组的起始地址
	      mov    dx,0           	;清除余数
	      mov    bx,10          	;除数
	      mov    cx,4           	;循环4次
	;循环除以10得到十进制结果并存入数组中
	p1:   
	      div    bx             	;除法
	      mov    num[si],dl     	;把余数存到 num 数组
	      mov    dx,0           	;清除余数
	      inc    si             	;指针自增
	      loop   p1

	;按数组倒序输出结果
	p2:   
	      dec    si             	;数组自减
	      mov    al,'0'         	;ascii码预备
	      add    al,num[si]
	      mov    dl,al          	;把数组中的每一个数放到 dl 输出
	      mov    ah,02h
	      int    21h
	      cmp    si,0           	;指针为0时结束循环
	      jnz    p2
		  
	mov    dx,offset LINE			;输出换行符
	mov    ah,09h
	int    21h
	mov    ah,4CH
	int    21H
CODE ENDS
END start