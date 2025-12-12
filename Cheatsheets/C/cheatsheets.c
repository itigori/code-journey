//主函数（main函数）
//C语言从主函数第一行开始执行
//int是整型的意思，main是函数名
#include <stdio.h>
int main()
{
    //printf是库函数-在屏幕上打印信息
    //printf的使用需要引用头文件<stdio.h>
    printf("BYE");
    return 0;
}

//数据类型
    //char 字符数字类型 - 1字节
    //short 短整型 - 2字节
    //int 整型 - 4字节
    //long 长整型 - 4字节
    //long long 长长整型 - 8字节
    //float 单精度浮点型 - 4字节
    //double 双精度浮点型 - 8字节

int main()
{
    printf("%d\n", 100);
    printf("%d\n", sizeof(char));
    printf("%d\n", sizeof(short));
    printf("%d\n", sizeof(int));
    printf("%d\n", sizeof(long));
    printf("%d\n", sizeof(long long));
    printf("%d\n", sizeof(float));
    printf("%d\n", sizeof(double));
    return 0;
}


//数据变量
int main()
{
    //创建一个变量
    //int是变量的类型
    int age = 20;
    double weight = 50;
    char ch = 1;

    age = age - 1;
    weight = weight - 10;

    //整型使用%d
    printf("%d\n", age);
    //浮点型使用%f
    printf("%f\n", weight);
    //字符型使用%d
    printf("%d\n", ch);
}


//全局变量 - {}外部定义
int num = 1;

int main()
{
    //局部变量 - {}内部定义
    //当全局变量和局部变量的名字冲突时，局部变量优先
    int num = 2;
    return 0;
}


//写一个代码求两个整数的和
//scanf函数是输入函数
//提示scanf不安全时改用建议选项，如果仍然使用scanf则在头部增加#define 错误 1
int main()
{
    int a = 0;
    int b = 0;
    int sum = 0;

    //scanf_s函数是VS编译器提供的不是C语言的标准规定的
    scanf_s("%d %d", &a, &b);
    
    sum = a + b;
    printf("sum = %d", sum);
    
    return 0;
}


//作用域
//局部变量的作用域就是变量所在的局部范围
//全局变量的作用域就是整个工程

int ALL = 12;

int main()
{
    printf("ALL = %d\n", ALL);

    int a =10;
    printf("%d\n", a);


    printf("ALL = %d\n", ALL);

    return 0;
}


//同一工程内，不同的项目需要共用同一个变量，需要另外一个项目声明
//extend int ALL;


//生命周期
//变量的生命周期就是变量的创建和销毁之间的时间段
//局部变量的生命周期就是进入局部范围开始，出局部范围结束
//全局变量的生命周期就是程序的生命周期

int main()
{
    int a =10;
    printf("%d\n", a);
    return 0;
}



//常量

//#define定义标识符常量，在主函数内定义也可以
#define MAX 10000
int main()
{
    //字面常量
    
    //const修饰的常变量
    const int num = 20;
    //num常量的值将不可更改 - 具有常属性（不可被改变的属性）
    printf("num = %d\n", num);

    //#define定义的标识符常量
    int n = MAX;
    printf("n = %d\n", n);

    return 0;
}

//枚举变量

enum Sex
{
    //这种枚举类型的变量未来可能的取值
    //枚举常量默认从0开始向下递增，enum函数内可赋值
    male = 3,
    female,
    other
};

int main()
{
    enum Sex s = male;

    printf("%d\n", male);
    printf("%d\n", female);
    printf("%d\n", other);

    return 0;
}


//字符串 - 由双引号引起的一串字符
//字符串在结尾的位置隐藏了一个\0的字符，\0是字符串的结束标志
//字符数组 - 数组是一串相同类型的元素

//使用strlen时遇到strlen未定义，需要引用头文件<string.h>
#include <string.h>
int main()
{
    char arr1[] = "hello";
    char arr2[] = { 'h', 'e', 'l', 'l', 'o'};
    char arr3[] = { 'h', 'e', 'l', 'l', 'o', '\0'};
    //打印字符串使用%s
    printf("%s\n", arr1);
    printf("%s\n", arr2);
    printf("%s\n", arr3);

    //求字符串的长度
    int len = strlen("abc");
    printf("%d\n", len);
    printf("%d\n", strlen(arr2));     //随机值
    printf("%d\n", strlen(arr3));

    return 0;
}


//转义字符 - 转变了原来的意思

int main()
{
    //打印字符使用%c
    printf("%c\n", 'c');

    //将'转义，在前加\使得'成为转义字符得到成功输出
    printf("%c\n", '\'');

    printf("%c\n", '\130');     //\130是八进制的数值输出，八进制的130是十进制的88
    //X - ASCII码的码值是88

    return 0;
}

//%a            //警告字符
//%b            //退格符
//％d			//整型输出
//％ld		    //长整型输出
//％o			//以八进制数形式输出整数
//％x		    //以十六进制数形式输出整数，或输出字符串的地址
//％u			//以十进制数输出unsigned型数据(无符号数)
//％c			//用来输出一个字符
//％s			//用来输出一个字符串
//％f			//用来输出实数，以小数形式输出，默认情况下保留小数点6位
//%.5f	    	//用来输出实数，保留小数点5位
//％e			//以指数形式输出实数
//％g			//根据大小自动选f格式或e格式，且不输出无意义的零


//选择语句

int main()
{
    int input = 0;  //存放输入值的变量
    printf("Join Bailu\n");
    printf("Will you study(1/0)?\n");
    scanf_s("%d", &input);
    
    if (input == 0)
        printf("Good\n");
    else
        printf("Bad\n");

    return 0;
}


//循环语句

int main()
{
    int line = 0;

    //到达30000时胜利
    while (line < 30000)
    {
        printf("Write Code:%d\n", line);
        line++;
    }

    if (line == 30000)
    {   
        printf("Victory");
    }

    return 0;
}



//假循环语句

int main()
{
    float u, d, h;
    
    //即在循环前运行该命令，且直到while关联的事件为假，才停止。
    do {
        printf("Please input Upper base, Bottom base and High:");
        scanf("%f %f %f", &u, &d, &h);

        if((d < 0)||(u < 0)||(h < 0))
            printf("Please input the right number\n");
    } while((d < 0)||(u < 0)||(h < 0));  //即d, u, h都大于0时，循环结束

    float S = (d + u) * h / 2 ;

    printf("%f\n", S);

    return 0;
}



//函数

int Add(int x, int y)
{
    int z = 0;
    z = x + y;
    return z;
}

int main()
{
    int num1 = 0;
    int num2 = 0;
    scanf_s("%d%d", &num1, &num2);

    int sum = Add(num1, num2);

    printf("%d\n", sum);

    return 0;
}


//数组

int main()
{
    //数组 - 一组相同类型的元素组合
    //数组是用下标来访问
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};
    int i = 0;
    while (i < 10)
    {
        printf("%d\n", arr[i]);
        i++;
    }
    char ch[5] = {'a', 'b', 'c'};

    return 0;
}


//算数操作符

int main()
{
    float a = 9 / 2;
    float b = 9.0 / 2;

    printf("%f\n", a);
    printf("%f\n", b);


    int c = 9 % 2;  //% - 取模（取余）

    printf("%d\n", c);

    return 0;
}


//移动操作符
//移动操作符移动的是二进制位

int main()
{
    int a = 2;
    int b = a << 1;

    printf("%d\n", b);

    return 0;
}   


//位操作符  &（按位与）    |（按位或）    ^（按位异或）


//赋值

int main()
{
    int a = 5;
    a += 5;

    printf("%d\n", a);

    return 0;
}


//单目操作符
//!逻辑反操作

int main()
{
    int a = 10;
    int b = 0;

    printf("%d\n", !a);
    printf("%d\n", !b);

    return 0;
}

//sizeof是一个操作符
//计算类型或变量的大小

int main()
{
    printf("%d\n", sizeof(int));
    return 0;
}

int main()
{
    int arr[10] = {0};
    printf("%d\n", sizeof(arr));   //计算数组的总大小，单位是字节
    printf("%d\n", sizeof(arr[0]));

    //求元素个数
    int num = sizeof(arr) / sizeof(arr[0]);
    printf("%d\n", num);
    
    return 0;
}


//按位取反 - 把所有二进制中的数字，1变成0，0变成1

int main()
{
    int a = 0;

    printf("%d\n", ~a);
    //~ 按（二进制）位取反   

    return 0;
}

//整数a = 0
//二进制为00000000000000000000000000000000
//按位取反为11111111111111111111111111111111

//整数在内存中存储的是补码，一个整数的二进制表示有三种
//原码
//反码
//补码

//-1：
//10000000000000000000000000000001（原码）
//11111111111111111111111111111110（反码）
//11111111111111111111111111111111（补码）    符号位不变，其他位按位取反   （反码＋1=补码） 

//正整数中原码、反码和补码相同


//前置++

int main()
{
    int a = 10;
    int b = ++a;//前置++ - 先++后使用   

    printf("%d\n", b);
    printf("%d\n", a);

    return 0;
}

//后置++

int main()
{
    int a = 10;
    int b = a++;//后置++ - 先使用后++

    printf("%d\n", a);
    printf("%d\n", b);

    return 0;
}


int main()
{
    double a = 3.14;

    int b = (int)3.14;

    printf("%d\n", a);
    //强制类型转换
    printf("%d\n", b);

    return 0;
}


//逻辑操作符 - 且%%，或||

int main()
{
    int a = 3;
    int b = 5;
    int c = a && b;//两个值同时为真，才是真（1），否则就是假（0）
    int d = a || b;//两个值有一个为真，就是真（1），全部为假才是假（0）

    printf("%d\n", c);
    printf("%d\n", d);

    return 0;
}



//条件操作符（三目操作符）
//exp1 ? exp2 : exp3

//exp1成立，exp2计算，整个表达式的结果是exp2的结果
//exp1不成立，exp3计算，整个表达式的结果是exp3的结果

int main()
{
    int a = 0;
    int b = 3;
    int max = 0;

    if (a > b)
        max = a;
    else
        max = b;

    return 0;
}

int main()
{
    int a = 0;
    int b = 3;
    int max = 0;

    max = a > b ? a : b;

    printf("%d\n", max);

    return 0;
}


//逗号表达式

int main()
{
    int a = 0;
    int b = 3;
    int c = 4;
    int d = (a = b + 2, c = a - 4, b = c + 2);
    //逗号表达式是从左到右依次计算的
    //整个表达式的结果是最后一个表达式的结果

    printf("%d\n", d);

    return 0;
}



//下标引用操作符 - []

int main()
{
    int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    printf("%d\n", arr[5]);

    return 0;
}



//函数调用操作符

int main()
{
    printf("hehe\n");
    //调用操作符的时候，函数名后面的括号就是函数调用操作符

    return 0;
}


//C语言提供的关键字，不能自己创建关键字
//关键字不能作为变量名

//C语言常见关键字：auto, break, case, char, const, continue, default, do, double else, enum, extern, float, for, goto, if, int, long, register, return, short, signed, sizeof, static, struct, switch, typeof, union, unsigned, void, volatile, while


//auto:自动的，每个局部变量都由auto修饰

int main()
{
    int a = 10;  //自动创建，自动销毁的 - 自动变量   因此局部变量前都应加auto，但因为局部变量都需要auto，因此可以省略
    auto int a = 10;

    return 0;
}


//break:跳出，在while循环语句中可以用于跳出循环

int main() 
{
    int count = 0;
    for (int i = 0; i < 10; i++) 
    {
        if (i == 5) 
        {
            break;
        }
        count++;
    }
    printf("循环执行了 %d 次\n", count); // 输出：循环执行了 5 次
}


//extern:声明外部符号
//在同一工程中跨源文件使用变量需要extern声明


//register:寄存器关键字

int main()
{
    register int num = 100;  //建议num的值存放在寄存器中
    //计算机中数据可以存储到：网盘、硬盘、内存、高速缓存、寄存器（速度依次递增，相对容量依次递减）

    return 0;
}


//signed:有符号的
//unsigned:无符号的


//define, include都不是关键字，而是预处理指令

//typedef 类型重定义

//给unsigned命名一个别名 u_int
typedef unsigned int u_int;

int main()
{
    unsigned int num = 100;
    u_int num2 = 100;

    return 0;
}


//static:静态的
//1.static修饰局部变量，改变了局部变量的生命周期（本质上是改变了变量的存储类型）
//2.static修饰全局变量
//3.static修饰函数

//static修饰全局变量。使得全局变量只能在自己所在的源文件内部使用


//全局变量，在其他源文件内部可以被使用，是因为全局变量具有外部链接属性，但被static修饰后就变成了内部链接属性，其他源文件不能链接到静态全局变量

//未加static, 每次循环a销毁
void test()
{
    int a = 1;
    a++;
    printf("%d\n", a);
}

int main()
{
    int i = 0;
    while (i <10)
    {
        test();
        i++;
    }
    return 0;
}

//加static, a将不会销毁
void test()
{
    static int a = 1;
    a++;
    printf("%d\n", a);
}

int main()
{
    int i = 0;
    while (i <10)
    {
        test();
        i++;
    }
    return 0;
}


//内存原理
//内存分为栈区，堆区，静态区
//栈区有局部变量，函数的参数
//堆区有动态内存分配
//静态区有全局变量，static修饰的静态变量


//switch语句
//一个 switch 语句允许测试一个变量等于多个值时的情况。每个值称为一个 case，且被测试的变量会对每个 switch case 进行检查
//仅仅会执行符合要求的case

int main()
{
    char grade = 'B'; /* 局部变量定义 */
    switch (grade)
    {
        case 'A':
            printf("well done!\n");
            break;
        case 'B':
        case 'C':
            printf("good\n");
            break;
        case 'D':
            printf("pass\n");
            break;
        case 'F':
            printf("try again\n");
            break;
        default:
            printf("lose\n");
    }
    printf("Your grade is %c\n", grade);
    return 0;
}


//常量和宏
//define 定义常量

#define MAX 1000

int main()
{
    printf("%d", MAX);
    return 0;
}

//define 定义宏

#define ADD(X, Y) X + Y
int main()
{
    printf("%d", 4*ADD(2, 3));// 4*2+3
    return 0;
}


#define ADD(X, Y) ((X) + (Y))
int main()
{
    printf("%d", 4*ADD(2, 3));//4*(2+3)
    return 0;
}


//指针

//32位 - 32根地址线 - 物理线 - 通电 - 1/0
//64位 - 64根地址线 - 物理线 - 通电 - 1/0
//电信号转换为数字信息 - 1和0组成的二进制序列
//最终是一个内存单元一个字节

int main()
{
    int a = 1; 
    printf("%p", &a);//%p - 专门打印内存地址

    int * pa = &a;//pa用于存放地址，在C语言中称为指针变量 - pa = &a
    //*说明pa是指针变量
    //int说明pa指向的对象是int类型的

    *pa = 20;//*解引用操作 *pa就是通过pa的地址找到a
    return 0;
}


//指针变量的大小

int main()
{
    printf("%d\n", sizeof(char*));
    printf("%d\n", sizeof(int*));
    printf("%d\n", sizeof(short*));
    printf("%d\n", sizeof(long*));
    printf("%d\n", sizeof(float*));
    return 0;
}
//指针大小是相同的，指针是用来存放地址的，取决于地址的大小
//32位平台 - 32bit - 4byte
//64位平台 - 64bit - 8byte

//结构体
//可以让C语言创建新的类型
//描述复杂对象
struct Stu
{
    char name[20];  //成员变量
    int age;
    double score;
};

struct Book
{
    char name[20];
    float price;
    char id[30];
};


int main(){
    struct Stu s = {'张三', '20', '85.5'};  //结构体的创建和初始化

    printf("%s %d %lf\n", s.name, s.age, s.score);  //结构体变量.成员变量
    
    struct Stu * ps = &s;

    printf("2 : %s %d %lf\n", (*ps).name, (*ps).age, (*ps).score);

    printf("3 : %s %d %lf", ps->name, ps->age, ps->score);

    return 0;
}