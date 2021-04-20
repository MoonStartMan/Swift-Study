//
//  main.swift
//  Swift-扩展
//
//  Created by 王潇 on 2021/4/1.
//

import Foundation

/**
    扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能。它还拥有不需要访问被扩展类型源代码就能完成扩展的能力(即逆向建模)。扩展和Objective-C的分类很相似。(与Objective-C分类不同的是,Swift扩展是没有名字的。)
 */


//  Swift中的扩展可以

//  添加计算型实例属性和计算型类属性
//  定义实例方法和类方法
//  提供新的构造器
//  定义下标
//  定义和使用新的嵌套类型
//  使已经存在的类型遵循(conform)一个协议

/**
    扩展可以给一个类型加新的功能,但是不能重写已经存在的功能。
 */

/**
    扩展的语法
 */

//  使用 extension 关键字声明扩展
//extension SomeType {
    //  在这里给 SomeType 添加新的功能
//}


//extension SomeType: SomeProtocol, AnotherProtocol {
//    //  协议所需要的实现写在这里
//}

/**
    计算型属性
 */

extension Double {
    var km: Double { return self * 1_000.0}
    var m: Double { return self }
    var cm: Double { return self / 100.0}
    var mm: Double { return self / 1_000.0}
    var ft: Double { return self / 3.28084}
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

/**
    构造器
 */

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

/**
    方法
 */

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

/**
    可变实例方法
 */

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

/**
    下标
 */

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

print(746381295[0]);    //  5
print(746381295[1]);    //  9
print(746381295[2]);    //  2
print(746381295[8]);    //  7
print(746381295[9]);    //  0

/**
    嵌套类型
 */

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
