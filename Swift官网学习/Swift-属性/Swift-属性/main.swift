//
//  main.swift
//  Swift-属性
//
//  Created by 王潇 on 2021/3/29.
//

import Foundation

/**
    存储属性
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
//  该区间表示整数 0, 1, 2
rangeOfThreeItems.firstValue = 6
//  该区间表示的整数6, 7, 8

/**
    常量结构体实例的存储属性
 */

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//  该区间表示整数 0, 1, 2, 3
//rangeOfFourItems.firstValue = 6
//  尽管 firstValue 是个可变属性，但这里还是会报错

/**
    延时加载存储属性
 */

class DataImporter {
    /**
        DataImporter 是一个负责将外部文件中的数据导入的类。
        这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"
    //  这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //  这里会提供数据管理功能
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//  DataManager 实例的 importer 属性还没有被创建

print(manager.importer.fileName);
//  DataImporter 实例的 importer 属性现在被创建了
//  输出"data.txt"

/**
    计算属性
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

/**
    简化 Setter 声明
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/**
    简化 Getter声明
 */

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/**
    只读计算属性
*/

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

class StepCounter {
    var totalSeps: Int = 0 {
        willSet(newTotalSteps) {
            print("将 totalSteps 的值设置为 \(newTotalSteps)")
        }
        didSet {
            if totalSeps > oldValue {
                print("增加了 \(totalSeps - oldValue) 步")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSeps = 200
//  将 totalSteps 的值设置为 200
//  增加了 200 步
stepCounter.totalSeps = 360
//  将 totalSteps 的值设置为 360
//  增加了 160 步
stepCounter.totalSeps = 896
//  将 totalStep 的值设置为 896
//  增加了 536 步

/**
    全局变量和局部变量
 */

 // 全局的常量或变量都是延迟计算的，跟延时加载存储属性相似，不同的地方在于，全局的常量或变量不需要标记 lazy 修饰符。
//  局部范围的常量和变量从不延迟出来

/**
    类型属性
 */

//  跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值
//  存储型类型属性是延迟初始化，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符

/**
    类型属性语法
 */

struct SomeStructure {
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//注意

//例子中的计算型类型属性是可读的，但也可以可读可写的计算型类型属性，跟计算型实例属性的语法相同。

/**
    获取和设置类型属性的值
 */

print(SomeStructure.storedTypeProperty)
//  打印"Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
//  打印"Another value."
print(SomeEnumeration.computedTypeProperty)
//  打印"6"
print(SomeClass.computedTypeProperty)
//  打印"27"

struct AudioChanel {
    static let threshouldLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChanel.threshouldLevel {
                //  将当前音量限制在阈值之内
                currentLevel = AudioChanel.threshouldLevel
            }
            if currentLevel > AudioChanel.maxInputLevelForAllChannels {
                //  存储当前音量作为新的最大输入音量
                AudioChanel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChanel()
var rightChannel = AudioChanel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
//  输出"7"
print(AudioChanel.maxInputLevelForAllChannels)
//  输出"7"

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChanel.maxInputLevelForAllChannels)
