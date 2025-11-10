"""
18.
完成类的继承体系：Animal类包含eat、drink、run、sleep方法；Dog类继承Animal类，新增bark方法；
XiaoTianQuan类继承Dog类，新增fly方法。最终创建哮天犬对象，调用其所有继承和自身的方法。
"""

class Animal:
    def eat(self):
        print("动物在吃东西")
    
    def drink(self):
        print("动物在喝水")
    
    def run(self):
        print("动物在奔跑")
    
    def sleep(self):
        print("动物在睡觉")

class Dog(Animal):
    def bark(self):
        print("狗在汪汪叫")

class XiaoTianQuan(Dog):
    def fly(self):
        print("哮天犬在飞翔")

# 创建哮天犬对象并调用所有方法
xtq = XiaoTianQuan()
xtq.eat()
xtq.drink()
xtq.run()
xtq.sleep()
xtq.bark()
xtq.fly()   