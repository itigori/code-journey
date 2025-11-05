//10.求水仙花数（水仙花数是个三位数，各位数的立方和是它本身）

#include <stdio.h>
int main()
{	
	int x, y, z;//个位，十位，百位
	int i;
	for (i = 100; i < 999; i++) {
		//通过取余分离各位数
		x = i % 10;
		y = i / 10 % 10;
		z = i / 100 % 10;

		if (x + y * 10 + z * 100 == x * x * x + y * y * y + z * z * z) {
			printf("%d%d%d\n", z, y, x);
		}
	}
	return 0;
}