//
//  main.swift
//  Swift-自动引用计数
//
//  Created by 王潇 on 2021/4/8.
//

import Foundation

//  Swift使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存。通常情况下，swift内存管理机制会一直起作用，你无须自己来考虑内存的管理。ARC会在类的实例不再使用时，自动释放其占用的内存。

/**
    自动引用计数的工作机制
 */

//  当你每次创建一个类的新的实例的时候，ARC会分配一块内存来储存该实例信息。内存中会包含实例的类型信息，以及这个实例所有相关的存储类型
//  当实例不在被使用时, ARC 释放实例所占用的内存，并让释放的内存能挪作他用。确保不再被使用的实例，不会一直占用内存空间。
//  当ARC收回和释放了正在被使用中的实例，改实例的属性和方法将不能再访问和调用。
//  为了确保使用中的实例不会被摧毁，ARC会跟踪和计算每一个实例正在被多少属性，常量和变量所引用。哪怕实例的引用数为1，ARC都不会销毁这个实例。
//  为了使上述成为可能，无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为"强"引用，是因为它会将实例牢牢地保持住，只要强引用还在，实例是不允许被销毁的。


/**
    自动引用计数实践
 */


//class Person {
//    let name: String
//    init(name: String) {
//        self.name = name
//        print("\(name) is being initialized")
//    }
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//var reference1: Person?
//var reference2: Person?
//var reference3: Person?
//
//reference1 = Person(name: "John Appleseed")
////  打印"John Appleseed is being initialized"
//
//reference2 = reference1
//reference3 = reference1
//
//reference1 = nil
//reference2 = nil
//
//reference3 = nil
//  打印"John Appleseed is being deinitialized"

/**
    类实例之间的循环强引用
 */

//class Person {
//    let name: String
//    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { print("\(name) is being deinitialized") }
//}
//
//class Apartment {
//    let unit: String
//    init(unit: String) { self.unit = unit }
//    var tenant: Person?
//    deinit { print("Apartment \(unit) is being deinitialized") }
//}
//
//var john: Person?
//var unit4A: Apartment?
//
//john = Person(name: "John Appleseed")
//unit4A = Apartment(unit: "4A")
//
//john!.apartment = unit4A
//unit4A!.tenant = john

/**
    解决实例之间的循环强引用
 */

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) 被析构") }
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    var tenant: Person?
    deinit { print("Apartment #\(number) 被析构") }
}

//  两个变量都初始化为nil
var runoob: Person?
var number73: Apartment?

//  赋值
runoob = Person(name: "Runoob")
number73 = Apartment(number: 73)

//  意感叹号是用来展开和访问可选变量 runoob 和 number73 中的实例
// 循环强引用被创建

runoob!.apartment = number73
number73!.tenant = runoob

//  断开 runoob 和 number73 变量所持有的强引用时，引用计数不会降为0，实例也不会被 ARC销毁
//  注意，当你把两个变量设为nil时，没有任何一个析构函数被调用.
//  强引用循环阻止了Person和Apartment类实例的销毁，并在你的应用程序中造成了内存泄露
runoob = nil
number73 = nil

/**
 解决实例之间的循环强引用
*/

//  Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题
    // 弱引用
    // 无主引用
    //  弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
    //  对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。

//  弱引用实例
class Module {
    let name: String
    init(name: String) { self.name = name }
    var sub: SubModule?
    deinit { print("\(name) 主模块") }
}

class SubModule {
    let number: Int
    
    init(number: Int) { self.number = number }
    
    weak var topic: Module?
    
    deinit { print("子模块 topic 数为 \(number)") }
}

var toc: Module?
var list: SubModule?
toc = Module(name: "ARC")
list = SubModule(number: 4)
toc!.sub = list
list!.topic = toc

toc = nil
list = nil

//  无主引用实例
class Student {
    let name: String
    var section: Marks?
    
    init(name: String) {
        self.name = name
    }
    
    deinit { print("\(name)") }
}

class Marks {
    let marks: Int
    unowned let stname: Student
    
    init(marks: Int, stname: Student) {
        self.marks = marks
        self.stname = stname
    }
    deinit{ print("学生的分数为 \(marks)") }
}

/**
    闭包引起的循环强引用
 */

//  循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了实例。这个闭包体中可能访问了实例的某个属性，例如self.someProperty，或者闭包中调用了实例的某个方法，例如self.someMethod。这两种情况都导致了闭包 "捕获" self，从而产生了循环强引用。

//  实例

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitalized")
    }
}

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

/**
    弱引用和无主引用
 */

//  当闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用。
//  相反的，当捕获引用有时可能会是nil时，将闭包内的捕获定义为弱引用。
//  如果捕获的引用绝对不会置为nil，应该用无主引用，而不是弱引用。

//class HTMLElement {
//    let name: String
//    let text: String?
//    lazy var asHTML: () -> String = {
//        [unowned self] in
//        if let text = self.text {
//            return "<\(self.name)>\(text)</\(self.name)>"
//        } else {
//            return "<\(self.name) />"
//        }
//    }
//    init(name: String, text: String? = nil) {
//        self.name = name
//        self.text = text
//    }
//    deinit {
//        print("\(name) 被析构")
//    }
//
//}
////创建并打印HTMLElement实例
//var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//print(paragraph!.asHTML())
//// HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息
//paragraph = nil
