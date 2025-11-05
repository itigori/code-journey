"""
6.
球的下落问题：球从 80 米高度自由下落，每次落地后返回原高度的一半再落下。
需编写函数求第 10 次落地时经过的总米数，以及第 10 次反弹的高度。
"""

def ball_fall():
    initial_height = 80  # 初始高度
    total_distance = initial_height  # 第1次下落距离
    current_height = initial_height  # 当前高度（用于计算反弹）
    
    # 计算第2到第10次落地的总距离（每次反弹+下落）
    for _ in range(9):  # 共9次反弹+下落
        current_height /= 2  # 反弹高度（是前一次高度的一半）
        total_distance += 2 * current_height  # 反弹上去+下落下来的距离
    
    # 第10次落地后的反弹高度（第10次反弹）
    tenth_bounce = current_height / 2
    return total_distance, tenth_bounce

total, bounce = ball_fall()
print(f"第10次落地时总距离：{total}米")  # 结果：239.6875米
print(f"第10次反弹高度：{bounce}米")      # 结果：0.078125米