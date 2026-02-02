// 根据输入的数字输出星期几

namespace Name
{
    class Progarm
    {
        static void Main(string[] args)
        {
          int weekNumber = Convert.ToInt32(Console.ReadLine());
            switch(weekNumber)
            {
                case 1:
                    Console.WriteLine("Monday");
                    break;
                case 2:
                    Console.WriteLine("Tuesday");
                    break;
                case 3:
                    Console.WriteLine("Wednesday");
                    break;
                case 4:
                    Console.WriteLine("Thursday");
                    break;
                case 5:
                    Console.WriteLine("Friday");
                    break;
                case 6:
                    Console.WriteLine("Saturday");
                    break;
                case 7:
                    Console.WriteLine("Sunday");
                    break;
                default:
                    break;
            }
        }
    }
}