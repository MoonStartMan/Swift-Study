//
//  main.swift
//  Swift-访问控制
//
//  Created by 王潇 on 2021/4/9.
//

import Foundation

/**
    访问控制
 */

//  访问控制可以限定其他源文件或模块中的代码对你的代码的访问级别。这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口。

//  你可以明确给单个类型(类、结构体、枚举)设置访问级别，也可以给这些类型的属性、方法、构造器、下标等设置访问级别。协议也可以被限定在一定的范围内使用，包括协议里的全局变量、变量和函数。

//  Swift不仅提供了多种不同的访问级别，还为某些典型场景提供了默认的访问级别，这样就不需要我们在每段代码中都申明显示访问级别。其实，结果只是开发一个单一target的应用程序，我们完全可以不用显示声明代码的访问级别。

//  注意：为了简单起见，对于代码中可以设置访问级别的特性(属性、基本类型、函数等)，在下面的章节中我们会称之为"实体"。

/**
    模块和源文件
 */

//  Swift 中的访问控制模型基于模块和源文件这两个概念。

//  模块指的是独立的代码单元，框架或应用程序会作为一个独立的模块来构建和发布。在Swift中，一个模块可以使用 import 关键字导入另外一个模块。
//  在Swift中，Xcode的每个target(例如框架或应用程序)都被当作独立的模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时,框架内容都将属于这个独立的模块。
// 源文件就是 swift 中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。

/**
    访问级别
 */

//  Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
//  Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
//  File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
//  Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。
//  Open 为最高访问级别(限制最少)，Private 为最低访问级别(限制最多)


/**
    访问级别基本原则
 */

/**
    默认访问级别
 */

/**
    单个 target 应用程序的访问级别
 */

/**
    访问控制语法
 */

//public class SomePublicClass {}
//internal class SomeInternalClass {}
//fileprivate class SomeFilePrivateClass {}
//private class SomePrivateClass {}

//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//fileprivate func someFilePrivateFunction() {}
//private func somePrivateFunction() {}

//class SomeInternalClass {}
//var someInternalConstant = 0

/**
    自定义类型
 */

//  如果想为一个自定义类型指定访问级别，在定义类型时进行指定即可。

public class SomePublicClass {  //  显式 public 类
    public var somePublicProperty = 0   //  显式 public 类成员
    var someInternalProperty = 0 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {} //  显式 fileprivate 类成员
    private func somePrivateMethod() {} //  显示 private 类成员
}

class SomeInternalClass {   //  隐式 internal 类
    var someInternalProperty = 0    //  隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {} //  显式 fileprivate 类成员
}

fileprivate class SomeFilePrivateClass {        // 显式 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

private class SomePrivateClass {                // 显式 private 类
    func somePrivateMethod() {}                  // 隐式 private 类成员
}

/**
    元组类型
 */


/**
    函数类型
 */

//func someFunction() -> (SomeInternalClass, SomePrivateClass) {
//    //  此处是函数实现部分
//}

/**
    枚举类型
 */

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

/**
    原始值和关联值
 */


/**
    嵌套类型
 */

/**
    子类
 */

//public class A {
//    fileprivate func someMethod() {}
//}

//public class B:A {
//    override internal func someMethod() {}
//}

//public class A {
//    private func someMethod() {}
//}

//internal class B:A {
//    override internal func someMethod() {
//        super.someMethod()
//    }
//}

/**
    Getter 和 Setter
 */

//struct TrackedString {
//    private(set) var numberOfEdits = 0
//    var value: String = "" {
//        didSet {
//            numberOfEdits += 1
//        }
//    }
//}

//var stringToEdit = TrackedString()
//stringToEdit.value = "This string will be tracked."
//stringToEdit.value += "This edit will increment numberOfEdits."
//stringToEdit.value += "So will this one."
//print("The number of edits is \(stringToEdit.numberOfEdits)")

//public struct TrackedString {
//    public private(set) var numberOfEdits = 0
//    public var value: String = "" {
//        didSet {
//            numberOfEdits += 1
//        }
//    }
//    public init() {}
//}

/**
    构造器
 */

/**
    默认构造器
 */

/**
    协议
 */

//  如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可。


/**
    Extension 的私有成员
 */

protocol SomeProtocol {
    func doSomething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

