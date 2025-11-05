"""
11.
从键盘输入一些字符，逐个写入磁盘文件，直到输入一个 “#” 为止。
"""

# 打开文件用于写入（若文件不存在则创建，存在则覆盖）
with open("input_chars.txt", "w", encoding="utf-8") as f:
    print("请输入字符（输入'#'结束）：")
    while True:
        char = input().strip()  # 获取输入并去除首尾空格
        if char == "#":
            break  # 遇到#则停止输入
        f.write(char)  # 逐个写入字符

print("字符已写入文件'input_chars.txt'")