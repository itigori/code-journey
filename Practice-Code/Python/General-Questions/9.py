"""
9.
已知列表 rlist = [2, 4, 6, 7, 10, 11]，将列表中的每个元素作为圆的半径，计算它们的面积
"""

import math  # 引入math模块，使用π值

rlist = [2, 4, 6, 7, 10, 11]
# 计算每个半径对应的面积（面积公式：π×r²）
areas = [math.pi * r ** 2 for r in rlist]

# 输出结果（保留2位小数便于查看）
print("各半径对应的圆面积：")
for r, area in zip(rlist, areas):
    print(f"半径{r}的面积：{area:.2f}")