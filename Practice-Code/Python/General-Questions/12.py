"""
12.
从键盘输入一个字符串，将小写字母全部转换成大写字母，然后输出到磁盘文件 “test” 中保存。
"""

# 从键盘输入字符串
input_str = input("请输入一个字符串：")

# 将小写字母转换为大写
upper_str = input_str.upper()

# 写入文件“test”
with open("test", "w", encoding="utf-8") as f:
    f.write(upper_str)

print("转换后的大写字符串已写入文件'test'")