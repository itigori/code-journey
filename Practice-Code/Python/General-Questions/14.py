"""
14.
编写一个计算减法的方法，当 ** 被减数（第一个数）小于减数（第二个数）** 时，抛出 “被减数不能大于减数” 的异常
"""

class SubtractionError(Exception):
    """自定义减法异常类"""
    pass

def subtract(a, b):
    """计算减法的方法，当被减数小于减数时抛出异常"""
    if a < b:
        raise SubtractionError("被减数不能大于减数")
    return a - b

if __name__ == "__main__":
    try:
        # 测试正常情况
        print(f"10 - 5 = {subtract(10, 5)}")
        # 测试异常情况（被减数 < 减数）
        print(f"3 - 10 = {subtract(3, 10)}")
    except SubtractionError as e:
        print(f"异常提示：{e}")