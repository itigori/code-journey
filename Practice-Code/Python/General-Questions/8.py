"""
8.
编写函数验证哥德巴赫猜想：任何大于 6 的偶数都可表示成两个素数之和
"""

# 辅助函数：判断是否为素数
def is_prime(num):
    if num <= 1:
        return False
    if num == 2:
        return True
    if num % 2 == 0:
        return False
    # 检查3到sqrt(num)的奇数
    for i in range(3, int(num**0.5) + 1, 2):
        if num % i == 0:
            return False
    return True

# 验证哥德巴赫猜想
def goldbach(m):
    if m <= 6 or m % 2 != 0:
        return "请输入大于6的偶数"
    # 寻找两个素数p和q，使p+q=m
    for p in range(2, m // 2 + 1):
        if is_prime(p) and is_prime(m - p):
            return f"{m} = {p} + {m - p}"
    return "未找到符合条件的素数对（理论上不存在）"

num = int(input("请输入一个大于6的偶数："))
print(goldbach(num))