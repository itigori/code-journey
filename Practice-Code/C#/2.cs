// 根据输入的行数输出对应的*号，且*前加空格，*在行数数量空格后面

namespace studyCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            int n = Convert.ToInt32(Console.ReadLine());

            for (int i = 1; i < n + 1; i++)
            {
                for (int j = 0; j < i; j++)
                {
                    if (j == i - 1)
                    {
                        Console.Write("*");
                    }
                    else
                    {
                        Console.Write(" ");
                    }
                }
                Console.WriteLine();
            }
        }
    }
}