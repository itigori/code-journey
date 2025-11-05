"""
3.
设计一个算法：判断1~100内的任意数是否为素数
"""

a = int(input("Please input any number in range of 1 to 100: "))
fg = 0
for i in range(2, a - 1):
    if a % i == 0:
        fg = 1
        break
    if fg == 0:
        print("This is prime number")
    else:
        print("This is not prime number")
