//18.猴子吃桃：猴子第一天摘下若干个桃子，当即吃下一半，又多吃了一个；第二天早上又吃一半，又多吃一个。
//以后每天都吃一半多一个。到第十条还剩一个桃子，求第一天一共摘了多少个桃子？

#include <stdio.h>
int main()
{	
	int day;
	int x = 10;
	int y = 0;
	//逆推
	for (day = 9; day >= 1; day--) {
		y = (x + 1) * 2;
		x = y;
	}
	printf("%d", y);
	return 0;
}