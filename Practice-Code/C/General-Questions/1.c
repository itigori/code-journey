//1.有1、2、3、4个数字，能组成多少个互不相同且无重复数字的三位数？都是多少？

#include <stdio.h>
int main()
{
    //建立百位，十位，个位的变量
	int b, s, g;
    //建立计数变量
	int count = 0;
    //遍历各数
	for (b = 1; b < 5; b++){
		for (s = 1; s < 5; s++){
			for (g = 1; g < 5; g++){
                //添加条件：个十百三位数互不相同
				if (g != s && s != b && g != b){
                    //输出结果
					printf("%d%d%d\n", b, s, g);
                    //添加计数
					count++;
				}
			}
		}
	}
    //输出计数
	printf("count = %d\n", count);
	return 0;
}