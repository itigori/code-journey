//7.输出99乘法表

#include <stdio.h>
int main()
{
	int i = 10;
	int j = 0;
	//j代表输出的行数
	for (j = 1; j <= 9; j++) {
		//i代表列数
		for (i = 1; i <= j; i++) {
			//公式取行列数即可
			printf("%d*%d=%d	", j, i, i*j);
		}
		printf("\n");
	}
	return 0;
}