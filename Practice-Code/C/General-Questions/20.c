//20.有一分数序列：2/1，3/2，5/3，8/5，13/8，21/13...求出这个数列的前20项之和
//程序分析：请抓住分子与分母的变化规律

#include <stdio.h>
int main()
{	
	int i;
	float sum = 0;
	float a = 2, b = 1;
	float t;
	for (i = 0; i < 20; i++) {
		sum += a / b;
		t = a;
		a = a + b;
		b = t;
	}
	printf("sum = %.2f", sum);
	return 0;
}
