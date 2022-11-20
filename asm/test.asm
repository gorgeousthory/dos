;作业5：屏幕指定位置输出结果
assume cs:code,ds:data,ss:stack
data segment
         db 'Hello World','$'    ;data段定义好要输出的字符串，需以'0'作为结束标志
data ends
stack segment
          db 128 dup(0)
stack ends
code segment
    start:          
                    mov  ax,data
                    mov  ds,ax
                    mov  ax,stack
                    mov  ss,ax
                    mov  sp,128
                    call initData           ;初始化数据并指定参数
                    call clearScreen        ;清屏
                    call getRow             ;获取指定行号的字节偏移数
                    call getCol             ;获取指定列号的字节偏移数
                    call showString         ;显示字符串
                    mov  ax,4c00h
                    int  21h
    ;============================================================
    initData:       
                    mov  ax,0B800h          ;文本模式下显存起始地址0B800h
                    mov  es,ax
                    mov  dh,10              ;指定行号
                    mov  dl,15              ;指定列号
                    mov  cl,00100000B       ;指定颜色
                    mov  si,0
                    mov  di,0
                    ret
    ;============================================================
    clearScreen:    
                    push cx                 ;保护下面将要用到的寄存器
                    push dx
                    push es
                    push bx
                    mov  cx,2000            ;一页有2000字符，每个字符2个字节
                    mov  dx,0700h           ;将屏幕上的双字用0700h空白符代替
                    mov  bx,0
    clearScreenLoop:
                    mov  es:[bx],dx
                    add  bx,2
                    loop clearScreenLoop
				
                    pop  bx                 ;还原寄存器
                    pop  es
                    pop  dx
                    pop  cx
                    ret
    ;============================================================
    getRow:                                 ;定位行数
                    mov  al,dh
                    mov  bl,160             ;一行80字符，160字节
                    mul  bl
                    mov  di,ax
                    ret
    ;============================================================
    getCol:                                 ;定位列数
                    mov  al,dl
                    mov  bl,2
                    mul  bl
                    add  di,ax
                    ret
    ;============================================================
    showString:     
                    push cx                 ;保护下面将要用到的寄存器
                    push ds
                    push es
                    push dx
                    push si
                    push di
				
                    mov  dh,cl              ;高位存颜色
                    mov  cx,0
    showStringLoop: 
                    mov  cl,ds:[si]
                    cmp  cl,'$'
                    je   showStringEnd      ;当符号为$表示字符结尾时结束输出循环
                    mov  dl,ds:[si]         ;低位存字符
                    mov  es:[di],dx
                    add  di,2
                    inc  si
                    jmp  showStringLoop				
    showStringEnd:  
                    pop  di                 ;还原寄存器
                    pop  si
                    pop  dx
                    pop  es
                    pop  ds
                    pop  cx
                    ret
    ;============================================================
code ends
end start