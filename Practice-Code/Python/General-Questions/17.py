"""
17.
使用加法运算重载，将列表[11,32,3,6]和[12,16,12,13]中对应元素进行相加
"""

class ListAdd:
    def __init__(self, lst):
        self.lst = lst
    
    def __add__(self, other):
        """重载加法运算符，实现对应元素相加"""
        return [a + b for a, b in zip(self.lst, other.lst)]

# 测试
list1 = ListAdd([11, 32, 3, 6])
list2 = ListAdd([12, 16, 12, 13])
result = list1 + list2
print("对应元素相加结果：", result)  # 输出：[23, 48, 15, 19]