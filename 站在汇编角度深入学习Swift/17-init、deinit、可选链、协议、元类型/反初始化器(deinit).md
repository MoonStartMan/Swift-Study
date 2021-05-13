# 反初始化器(deinit)

+ deinit叫做反初始化器，类似于C++的析构函数、OC中的dealloc方法
	+ 当类的实例对象被释放内存时，就会调用实例对象的deinit方法
	
	``` swift
	
    class Person {
      deinit {
          print("Person对象销毁了")
      }
  }
	
	```
	
+ ```deinit```不接受任何参数，不能写小括号，不能自行调用
	+ 父类的```deinit```能被子类继承
	+ 子类的```deinit```实现执行完毕后会调用父类的```deinit```


``` swift

class Person {
    deinit {
        print("Person对象销毁了")
    }
}

class Student: Person {
    deinit {
        print("Student对象摧毁了")
    }
}

var stu: Student? = Student()   //  ARC
stu = Student()

func test() {
    var stu = Student()
}

print("1")
test()
print("2")

```