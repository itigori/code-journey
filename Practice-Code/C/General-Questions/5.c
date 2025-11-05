//5.输入三个整数x, y, z, 请把这三个数从小到大输出

#include <stdio.h>
int main() {
    //创建变量
	int a, b, c, t;
    //获取三个数
	printf("Please enter three number:\n");
	scanf("%d,%d,%d", &a, &b, &c);
    //置换
	if (a > b) {	// 3 2 1
		t = a;	// t=3
		a = b;	// a=2
		b = t;	// b=3
	}
	if (a > c) {
		t = a;	// t=2
		a = c;	// a=1
		c = t;	// c=2
	}
	if (b > c) {
		t = b;	// t=3
		b = c;	// b=2
		c = t;	// c=3
	}
    //输出结果
	printf("%d %d %d", a, b, c);
	return 0;
}