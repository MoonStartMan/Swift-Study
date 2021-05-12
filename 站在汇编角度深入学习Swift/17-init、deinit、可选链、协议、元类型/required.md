# required

+ 用required修饰指定初始化器，表明其所有子类必须实现该初始化器(通过继承或者重写实现)
+ 如果子类重写了required初始化器，时也必须加上required，不用加override

``` swift

class Person {
    required init() { }
    init(age: Int) { }
}

class Student: Person {
    required init() {
        super.init()
    }
}

```

