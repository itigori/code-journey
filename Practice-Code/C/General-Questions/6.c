//6.用*号输出字母C的图案

#include <stdio.h>
int main()
{
	int m = 5;
	int i = 0;
	//按结构输出
	for (i = 0; i < m; i++) {
		printf("*");
	}
	printf("\n");
	for (i = 0; i < m-1; i++) {
		printf("*\n");
	}
	for (i = 0; i < m; i++) {
		printf("*");
	}
	printf("\n");
	return 0;
}