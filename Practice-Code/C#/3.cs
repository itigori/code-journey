// 九九乘法表
namespace studyCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            for (int i = 1; i <= 9; i++)
            {
                for (int j = 1; j <= i; j++)
                {
                    Console.Write("{0} x {1} = {2}\t", j, i, i * j);
                }
                Console.WriteLine();
            }
        }
    }
}