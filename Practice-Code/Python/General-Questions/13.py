"""
13.
分别把 string（字符串）、list（列表）、tuple（元组）、dict（字典）写入文件中。
"""

# 定义不同类型的变量
string_data = "这是一个字符串示例"
list_data = [10, 20, "Python", True, 3.14]
tuple_data = ("苹果", "香蕉", 5, False)
dict_data = {"姓名": "李四", "年龄": 30, "职业": "工程师"}

# 写入文件
with open("data_types.txt", "w", encoding="utf-8") as f:
    f.write(f"字符串（string）：{string_data}\n")
    f.write(f"列表（list）：{list_data}\n")
    f.write(f"元组（tuple）：{tuple_data}\n")
    f.write(f"字典（dict）：{dict_data}\n")

print("string、list、tuple、dict已写入文件'data_types.txt'")