//15.求s=a+aa+aaa+aaaa+aaaaa+......的值，其中a是一个数字
/*例如2+22+222+2222+22222（此时有5个数相加）
几个数相加有键盘控制
*/

#include <stdio.h>
int main()
{	
	int n = 1;
	int a = 2;
	int t = a;
	//先让sum获取第一个a值
	int sum = 0 + a;
	//通过while循环，让a个数不断增加，同时在循环末尾给sum赋值
	while (n <= 4) {
		a *= 10;
		a += t;
		printf("%d\n", a);
		n++;
		sum += a;
	}
	printf("%d", sum);
	return 0;
}