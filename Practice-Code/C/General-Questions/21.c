//21.求1+2!+3!+...+20!的和

#include <stdio.h>
//阶乘需要考虑越界，使用long double扩大界限
long double ch(int m) {
	long double cj = 1;
	int j;
	for (j = 1; j <= m; j++) {
		cj *= j;
	} 
	return cj;
}

int main()
{	
	long double ch(int m);
	int i;
	long double sum = 0;
	for (i = 1; i <= 20; i++) {
		sum += ch(i);
	}
	printf("%lf", sum);
	return 0;
}