# 汇编语言学习(倒序更新)

TJUSSE22-23学年第01学期汇编语言课程作业文档
注：各次作业在asm文件夹下

## 目录

- [汇编语言学习(倒序更新)](#汇编语言学习倒序更新)
  - [目录](#目录)
  - [作业4：多模块与宏汇编练习](#作业4多模块与宏汇编练习)
  - [作业3：输入并输出年月日（过程调用练习）](#作业3输入并输出年月日过程调用练习)
  - [作业2：九九乘法表的输出](#作业2九九乘法表的输出)
  - [作业1：1到100的累加](#作业11到100的累加)
  - [编译环境](#编译环境)

---

## 作业4：多模块与宏汇编练习

本次作业将作业拆分为三个模块，分别为：

- homework41——主程序模块，初始化程序并调用子程序模块
- homework42——累加模块（calSum），循环一百次将结果存入ax寄存器中
- homework43——输出模块（outRes），将ax中的16进制结果13BA转换为10进制存入内存数组中，并在屏幕上逐个打印结果

多模块汇编的要点：

1. 定义远端函数时，函数最后的返回ret要写为retf
2. 在定义远端函数的文件头，要用public **farFunc(函数名)** 的方式声明远端函数
3. 在调用远端函数的文件头，要用extrn **farFunc(函数名)**:far
4. 在调用远端函数时，要使用call far ptr **farFunc(函数名)** 的方式调用
5. 编译时将所有文件都进行编译生成.obj文件，在link时将所有obj文件都进行链接才能生成完整的.exe执行文件

宏汇编的练习：在homework41.asm中定义了next用于输出换行符
![换行宏代码展示](/asm/Screenshots/换行宏代码.png)

使用时可直接将next当作指令单独使用

运行结果如下：
![多模块输出结果](/asm/Screenshots/多模块输出结果.png)

---

## 作业3：输入并输出年月日（过程调用练习）

代码实现主要有**初始化**、**输入日期**、**输出日期**三个大模块。
**初始化模块**包括载入准备数据、输出提示信息以及输出响铃符（ascii码为07h；**输入日期模块**则是逐位调用GetNum过程获取用户输入的日期，并根据输入规定的格式将每个数字存入日期信息的字符串里，输入格式为六位数字，每两位分别表示月日年，如062002表示2002年6月20日；**输出日期模块**则是直接换行输出日期信息的字符串即可。结果如下所示：
![日期输出结果截图](/asm/Screenshots/日期输出结果截图.png)

---

## 作业2：九九乘法表的输出

代码分为主要分为四个模块：row、col、next三个代码段与output一个过程，逻辑关系如下：

```伪代码
    row seg 循环（控制行数）
        col seg 循环（控制列数）
            output proc 输出结果
        next seg 控制换行
```

row控制第一层循环，col控制第二层，output作为循环体输出结果，next在一次row循环中输出换行符。

输出结果如下：
![乘法表输出结果截图](/asm/Screenshots/乘法表输出结果截图.png)

---

## 作业1：1到100的累加

**1、使用loop循环指令**
代码截图
![代码1截图](/asm/Screenshots/loop代码截图.png)

**2、 使用Jxx条件跳转指令**
代码截图
![代码2截图](/asm/Screenshots/Jxx代码截图.png)

**3、 运行结果**
![运行结果](/asm/Screenshots/累加结果运行截图.png)

---

## 编译环境

作业1、作业2：dosbox MASM-v6.11
作业3：dosbox-x MASM-v6.11
