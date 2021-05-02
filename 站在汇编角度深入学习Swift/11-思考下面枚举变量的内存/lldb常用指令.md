# lldb常用指令

+ 读取寄存器的值

``` lldb

register read/格式
register read/x

```

+ 修改寄存器的值

``` lldb

register write 寄存器名称 数值
register write rax 0

```

+ 读取内存中的值

``` lldb

x/数量-格式-字节大小 内存地址
x/3xw 0x0000010

```

+ 修改内存中的值

``` lldb

memory write 内存地址 数值
memory write 0x0000010 10

```

+ 格式

``` lldb

x是16进制, f是浮点, d是十进制

```

+ 字节大小

``` lldb

b - byte 1字节
h - half word 2字节
w - word 4字节
g - giant word 8字节

```

+ expression 表达式

``` lldb

可以简写: expr表达式
expression: $rax
expression: $rax = 1

```

+ po表达式
+ print表达式

``` lldb

po/x $rax

```

+ 单步运行,把子函数当做整体一步执行(源码级别)

``` lldb

thread step-over、 next、 n

```

+ 单步运行,遇到子函数会进入子函数(源码级别)

``` lldb

thread step-in、 step、 s

```

+ 单步运行,把子函数当做整体一步执行(汇编级别)

``` lldb

thread step-inst-over、 nexti、 ni

```

+ 单步运行,遇到子函数会进入子函数(汇编级别)

``` lldb

thread step-inst、 stepi、 si

```

+ 直接执行完当前函数的所有代码,返回到上一个函数(遇到断点会卡住)

``` lldb

thread step-out、 finish

```

rip存储的是指令的地址

CPU要执行的下一条指令地址就存储在rip中