using System; //引入命名空间


namespace Name //命名一般不使用中文
{
    class Progarm //类
    {
        static void Main(string[] args) //方法
        {
            Console.Writeline("Hello");

            //输出方法
            Console.Writeline("Hello"); //不换行
            Console.Write("Hello"); //会换行
            
            Console.Writeline("Hello\n \t"); //换行  制表符
        }
    }
}

//变量的创建和声明
namespace Bianliang
{
    class Progarm
    {
        static void Main(string[] args)
        {
            //创建变量
            //创建了一个变量，容器名为age，类型为int
            int age;
            //变量赋值
            age = 10;
        }
    }
}

//字符类型
namespace Zifu
{
    class Progarm
    {
        static void Mian(string[] args)
        {
            char a = 'a';
            int b = a;
            Console.Writeline(b);
        }
    }
}

namespace Zifu2
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int a = 23;
            char b = (char)a;//强制转换
        }
    }
}

namespace Zifu3
{
    class Progarm
    {
        static void Main(string[] args)
        {
            Console.Writeline("C:\\a");//双斜杠屏蔽转义字符
            Console.Writeline(@"C:\a");//加@屏蔽转义字符

            string str = @"C:\a\t\n";
            Console.Writeline(str);

            string str2 = @"
            ssss
            sssss";//@还可以用于添加需要换行的字符串

            string str3 = "abc" + "def";//两个字符串相加
        }
    }
}

//获取输入值
namespace Read
{
    class Progarm
    {
        static void Main(string[] args)
        {
            string str = Console.ReadLine();//字符串读取用户输入
            Console.Writeline(str);

            int str1 = Convert.ToInt32(str);//将字符串转化为整数
            Console.Writeline(str1);
        }
    }
}

//字符串格式化输出
namespace Zifu4
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int a = 3, b = 4;
            int c = 0;
            Console.Writeline("{0}+{1}={2}", a, b, a + b);

            Console.Writeline("{0}+{1}+{1}={2}", 1, 2, 5);
        }
    }
}

//数学运算符
namespace Math
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int a = 45 + 10;
            int b = 45 - 10;
            int c = 45 * 10;
            int d = 45 / 10;//当两个变量都为整数时，结果将取整
            int e = 45 % 10;

            double f = 45 / 10.0;

            //赋值运算符
            a += 1;
            //自增运算符
            b = a++;
        }
    }
}

//布尔类型
namespace Bool
{
    class Progarm
    {
        static void Main(string[] args)
        {
            bool a = true;//1
            bool b = false;//0
            Console.Writeline(a);//输出True
        }
    }
}

//逻辑运算符
namespace Logic
{
    class Progarm
    {
        static void Main(string[] args)
        {
            /*
            &&  逻辑和
            ||  逻辑或
            !   逻辑非    
            */
        }
    }
}

//if条件语句
namespace IF
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int age = Convert.ToInt32(Console.ReadLine());
            //if语句
            if (age <= 16)
            {
                Console.Writeline("小于16岁");
            }
            else
            {
                Console.Writeline("大于16岁");
            }
        }
    }
}

//if和elseif语句
namespace study
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int age = Convert.ToInt32(Console.ReadLine());
            if (age <= 16)
            {
                Console.Writeline("<=16");
            }
            else if (age > 16 && age <= 18)
            {
                Console.Writeline("16:18");
            }
            else
            {
                Console.Writeline(">18");
            }
        }
    }
}


//switch语句
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int a = 1;
            switch (a)
            {
                case 1:
                    Console.Writeline("A");
                    break;
                case 2:
                    Console.Writeline("B");
                    break;
                default:
                    Console.Writeline("C");
                    break;
            }
        }
    }
}

//while语句
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int a = 1;
            while (a < 10)
            {
                i++;
                Console.Writeline("True");
            }
            Console.Writeline("False");
        }
    }
}


//for循环
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            for (int i = 1; i < 10; i++)
            {
                Console.Writeline(i);
            }
        }
    }
}


//do while语句
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            int i = 1;
            do
            {
                i++;
                Console.Writeline(i);
            } while (i < 10);
        }
    }
}


//Continue
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            for (int i = 1; i <= 10; i++)
            {
                if (i % 2 == 0)
                {
                    continue;
                }
            }
        }
    }
}

/*字节类型
整型：sbyte(1),byte(1),short(2),ushort(2),int(4),uint(4),long(8),unlong(8)(依次从小到大)
s有负,u没负
浮点型：float(4),double(8)
*/

//字节类型转换
namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
            byte a = 1;
            int b = 2;
            a = (byte)b;

            //字符串转换
            Convert.ToByte(Console.ReadLine());
        }
    }
}


//数组
namespace Name
{
        class Progarm
    {
        static void Main(string[] args)
        {
            int[] ages = { 1, 2 };
            //索引是从零开始
            Console.Writeline(ages[0]);//访问1

            //新增数据
            ages = new int[10];
        }
    }
}