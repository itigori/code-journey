//13.输入两个正整数n和m，求其最大公约数和最小公倍数
/*程序分析：
（1）最小公倍数 = 两个数的积 / 最大公约数
（2）最大公约数用辗转相除法（欧几里得算法）
*/

#include <stdio.h>
int main()
{	
	int a = 2;
	int b = 1;
	int r;
	int c;
	int a1 = a;
	int b1 = b;
	
	//欧几里得算法，持续将b赋值给a，将余数r赋值给b，最后当r=0时即完成整除，此时b是最大公约数
	r = a % b;
	while (r != 0) {
		a = b;
		b = r;
		r = a % b;
	}
	//最小公倍数 = 两个数的积 / 最大公约数
	c = a1 * b1 / b;

	printf("最大公约数：%d", b);
	printf("最小公倍数：%d", c);
	return 0;
}