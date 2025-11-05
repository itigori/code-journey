//14.输入一行字母，分别统计出其中的英文字母、空格、数字和其他字符的个数

#include <stdio.h>
int main()
{	
	char c;
	int letter = 0;
	int number = 0;
	int space = 0;
	int other = 0;
	c = getchar();
	//通过循环来重复获取输入的字符，输入一个判断一个，当回车时停止。
	//循环内通过字符码来判断是字母还是数字还是空格还是其他
	while (c!='\n') {
		if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
			letter++;
		}
		else if (c >= '0' && c <= '9') {
			number++;	
		}
		else if (c = ' ') {
			space++;
		}
		else {
			other++;
		}
		c = getchar();
	}

	printf("字母=%d,数字=%d,空格=%d,其他=%d", letter, number, space, other);
	return 0;
}
