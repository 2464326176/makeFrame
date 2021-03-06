/*
 * @Author: yuhang.liu 
 * @Date: 2021-03-12 09:24:37 
 * @Last Modified by:   yuhang.liu 
 * @Last Modified time: 2021-03-12 09:24:37 
 */
# makeFrame
makefile gcc g++ 总结

gcc编译阶段
1.预处理（头文件展开 宏替换 去掉注释）
2.编译器（c文件变成汇编文件）
3.汇编器（汇编文件变成二进制文件）
4.链接器（将函数库对应的代码组合到目标文件）
hello.worldllo
1.gcc -E hello.c -o hello.i
2.gcc -S hello.i -o hello.s
3.gcc -c hello.s -o hello.o
4.gcc hello.o -o hello

动态库和静态库生成链接
静态库：
gcc -c hello.c -o hello.o
ar -crv libhello.a hello.o
Linux ar命令用于建立或修改备存文件，或是从备存文件中抽取文件。
ar可让您集合许多文件，成为单一的备存文件。在备存文件中，所有成员文件皆保有原来的属性与权限。
语法
ar[-dmpqrtx][cfosSuvV][a<成员文件>][b<成员文件>][i<成员文件>][备存文件][成员文件]
参数：
必要参数：
-d 　删除备存文件中的成员文件。
-m 　变更成员文件在备存文件中的次序。
-p 　显示备存文件中的成员文件内容。
-q 　将文件附加在备存文件末端。
-r 　将文件插入备存文件中。
-t 　显示备存文件中所包含的文件。
-x 　自备存文件中取出成员文件。
选项参数：
a<成员文件> 　将文件插入备存文件中指定的成员文件之后。
b<成员文件> 　将文件插入备存文件中指定的成员文件之前。
c 　建立备存文件。
f 　为避免过长的文件名不兼容于其他系统的ar指令指令，因此可利用此参数，截掉要放入备存文件中过长的成员文件名称。
i<成员文件> 　将文件插入备存文件中指定的成员文件之前。
o 　保留备存文件中文件的日期。
s 　若备存文件中包含了对象模式，可利用此参数建立备存文件的符号表。
S 　不产生符号表。
u 　只将日期较新文件插入备存文件中。
v 　程序执行时显示详细的信息。
V 　显示版本信息。

动态库：
gcc -fPIC -c child.c -o child.o     
gcc -shared child.o -o libchild.so  

g++(gcc)编译选项
-shared ：指定生成动态链接库。
-static ：指定生成静态链接库。
-fPIC ：表示编译为位置独立的代码，用于编译共享库。目标文件需要创建成位置无关码，念上就是在可执行程序装载它们的时候，它们可以放在可执行程序的内存里的任何地方。
-L. ：表示要连接的库所在的目录。
-l：指定链接时需要的动态库。编译器查找动态连接库时有隐含的命名规则，即在给出的名字前面加上lib，后面加上.a/.so来确定库的名称。
-Wall ：生成所有警告信息。
-ggdb ：此选项将尽可能的生成gdb的可以使用的调试信息。
-g ：编译器在编译的时候产生调试信息。
-c ：只激活预处理、编译和汇编,也就是把程序做成目标文件(.o文件)。
-Wl,options ：把参数 (options) 传递给链接器 ld 。如果 options 中间有逗号 , 就将 options 分成多个选项 , 然后传递给链接程序。

