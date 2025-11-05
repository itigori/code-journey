//9.判断101到202之间的素数

#include <stdio.h>
//建立判断函数，当某个数被整除时，o变量发生改变，即可以通过判断o是否为零来判断是不是素数
static int isPrimeNumber(int m) {
	int i, o = 0;

	for (i = 2; i < m; i++) {
		if (m % i == 0) {
			o++;
		}
	}
	if (o != 0) {
		return 0;
	}
	else {
		return 1;
	}
}

int main()
{	
	int isPrimeNumber(int m);
	for (int j = 101; j < 200; j++) {
		if (isPrimeNumber(j)) {
			printf("%d\n", j);
		}
	}
	return 0;
}