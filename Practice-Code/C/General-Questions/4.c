//4.输入某年某月某日，判断这天是这一年的第几天

#include <stdio.h>
int main()
{
    //创建变量
	int year, month, day;
	int sum, leap = 0;
    //获取日期
	printf("Please enter year, month and day:");
	scanf_s("%d,%d,%d", &year, &month, &day);

    //判断是否为闰年
	if (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)) {
		leap = 1;
	}
	else {
		leap = 0;
	}

    //switch语句判断月份
	switch (month) {
	case 1:
		sum = 0; 
		break;
	case 2:
		sum = 31;
		break;
	case 3:
		sum = 59;
		break;
	case 4:
		sum = 90;
		break;
	case 5:
		sum = 120;
		break;
	case 6:
		sum = 151;
		break;
	case 7:
		sum = 181;
		break;
	case 8:
		sum = 212;
		break;
	case 9:
		sum = 243;
		break;
	case 10:
		sum = 273;
		break;
	case 11:
		sum = 304;
		break;
	case 12:
		sum = 335;
		break;
	default:
		printf("Please enter right date!");
	}

    //依照闰年判断结果增加sum值
	if (leap == 1 && month > 2) {
		sum++;
	}

	sum = sum + day;
    //输出结果
	printf("Number is %d\n", sum);
	return 0;
}