// 给指定的内存空间起名
#include <iostream>
using namespace std;
int main() {
    // 变量创建的语法： 数据类型 变量名 = 变量初始值
    int a = 10;
    cout << a << endl;
    system("pause");
    return 0;
}

// 常量 - 用于记录程序中不可更改的数据

// 常量定义方式
// #define 宏常量
// const修饰的变量

#define day 7

int main() {
    cout<<"一周有"<< day << "天" <<endl;

    const int month = 12;
    cout<< month <<endl;

    system("pause");
    return 0;
}

// 关键字 - 在定义变量或常量时，不要使用关键字


