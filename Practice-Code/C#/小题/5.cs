// 输入四个整数，输出最大和最小值
namespace studyCSharp
{
    class Program
    {
        static void Main(string[] args)
        {
            int a = Convert.ToInt32(Console.ReadLine());
            int b = Convert.ToInt32(Console.ReadLine());
            int c = Convert.ToInt32(Console.ReadLine());
            int d = Convert.ToInt32(Console.ReadLine());
            
            int max = a > b ? a : b;
            if (max < c)
            {
                max = c;
            }

            if (max < d)
            {
                max = d;
            }
            
            int min = a < b ? a : b;
            if (min > c)
            {
                min = c; 
            }

            if (min > d)
            {
                min = d;
            }
            
            Console.WriteLine("{0} {1}", max, min);
        }
    }
}