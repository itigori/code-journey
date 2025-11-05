"""
4.
定义四个函数：max_divider（求最大公约数）、min_multiplier（求最小公倍数），函数参数为从键盘输入的两个整数
并举例说明（如输入 4 和 6，最大公约数为 2，最小公倍数为 12）
"""

# 求最大公约数（辗转相除法）
def max_divider(a, b):
    while b != 0:
        a, b = b, a % b
    return a

# 求最小公倍数（两数乘积÷最大公约数）
def min_multiplier(a, b):
    if a == 0 or b == 0:
        return 0  # 避免输入0的情况
    return a * b // max_divider(a, b)

# 从键盘输入并验证
num1 = int(input("请输入第一个整数："))
num2 = int(input("请输入第二个整数："))
print(f"{num1}和{num2}的最大公约数：{max_divider(num1, num2)}")
print(f"{num1}和{num2}的最小公倍数：{min_multiplier(num1, num2)}")