"""
15.
猜数字游戏：数字范围为1~100，输入必须是整数；若输入非法则抛出异常。
"""

import random

def guess_number_game():
    """猜数字游戏，包含输入合法性的异常处理"""
    target = random.randint(1, 100)  # 生成1~100的随机目标数
    while True:
        try:
            guess = input("请输入1~100之间的整数：")
            # 检查输入是否为整数
            if not guess.isdigit():
                raise ValueError("输入必须是整数！")
            guess = int(guess)
            # 检查输入是否在1~100范围内
            if guess < 1 or guess > 100:
                raise ValueError("输入必须在1~100之间！")
            
            # 猜数字逻辑
            if guess == target:
                print("恭喜猜对了！")
                break
            elif guess < target:
                print("太小了，再试试~")
            else:
                print("太大了，再试试~")
        except ValueError as e:
            print(f"输入异常：{e}")

if __name__ == "__main__":
    guess_number_game()