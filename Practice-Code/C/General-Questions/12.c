//12.利用条件运算符的嵌套来完成此题：学习成绩>=90分的同学用A表示，60-89分之间的用B表示，60分以下的用C表示。
//程序分析：(a>b)?a:b

#include <stdio.h>
int main()
{	
	int score = 3;
	//利用条件判断嵌套分析A、B、C
	char grade = (score >= 90) ? 'A' : ((score >= 60) ? 'B' : 'C'); 
	printf("%c", grade);
	return 0;
}