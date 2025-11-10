"""
16.
创建一个模块文件，用于比较两个数的大小
"""

def compare(a, b):
    """比较两个数a和b的大小，返回大小关系的描述"""
    if a > b:
        return f"{a} 大于 {b}"
    elif a < b:
        return f"{a} 小于 {b}"
    else:
        return f"{a} 等于 {b}"


if __name__ == "__main__":
    # 模块自我测试（直接运行模块时执行）
    test_cases = [(5, 3), (2, 7), (4, 4)]
    for num1, num2 in test_cases:
        print(compare(num1, num2))