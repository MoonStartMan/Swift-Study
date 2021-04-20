//
//  main.swift
//  Swift-方法
//
//  Created by 王潇 on 2021/3/29.
//

import Foundation

/**
    实例方法
 */

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
//  初始计数值是0
counter.increment()
//  计算值现在是1
counter.increment(by: 5)
//  计算值现在是6
counter.reset()
//  计算值现在是0

/**
    self属性
 */

//class Counter {
//    var count = 0
//    func increment() {
//        self.count += 1
//    }
//    func increment(by amount: Int) {
//        count += amount
//    }
//    func reset() {
//        count = 0
//    }
//}

//struct Point {
//    var x = 0.0, y = 0.0
//    func isToTheRightOf(x: Double) -> Bool {
//        return self.x > x
//    }
//}
//
//let somePoint = Point(x: 4.0, y: 5.0)
//if somePoint.isToTheRightOf(x: 1.0) {
//    print("This point is to the right of the line where x == 1.0")
//}
//  打印 "This point is to the right of the line where x == 1.0"

/**
    在实例方法中修改值类型
 */

//  mutating(可变)行为
//struct Point {
//    var x = 0.0, y = 0.0
//    mutating func moveBy(x deltaX: Double, y delatY:Double) {
//        x += deltaX
//        y += delatY
//    }
//}
//var somePoint = Point(x: 1.0, y: 1.0)
//somePoint.moveBy(x: 2.0, y: 3.0)
//print("The point is now at \(somePoint.x), \(somePoint.y)")

//  let fixedPoint = Point(x: 3.0, y: 3.0)
//  fixedPoint.moveBy(x: 2.0, y: 3.0)

//  不能在结构体类型的常量上调用可变方法，因为其属性不能被改变，即使属性是变量属性。

/**
    在可变方法中给self赋值
 */
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
//  ovenLight 现在等于 .high
ovenLight.next()
//  ovenLight 现在等于 .off

/**
    类型方法
 */

class SomeClass {
    class func someTypeMethod() {
        //  在这里实现类型方法
    }
}
SomeClass.someTypeMethod()

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
