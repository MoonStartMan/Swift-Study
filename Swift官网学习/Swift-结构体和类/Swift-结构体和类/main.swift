//
//  main.swift
//  Swift-结构体和类
//
//  Created by 王潇 on 2021/3/27.
//

import Foundation

/**
    结构体和类对比
 */


/**
    类型定义的语法
 */

struct SomeStructure {
    //  在这里定义结构体
}

class SomeClass {
    //  在这里定义类
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/**
    结构体和类的实例
 */

let someResolution = Resolution()
let someVideoMode = VideoMode()

/**
    属性访问
 */

print("The width of someResolution is \(someResolution)")
//  打印 "The width of someResolution is 0"

print("The width of someVideoMode is \(someVideoMode.resolution.width)")
//  打印 "The width of someVideoMode is 0"

someVideoMode.resolution.width = 1280
print("The width of somevideoMode is now \(someVideoMode.resolution.width)")
//  打印 "The width of someVideoMode is now 1280"

/**
    结构体类型的成员逐一构造器
 */

let vga = Resolution(width: 640, height: 480)

/**
    结构体和枚举是值类型
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}

var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

/**
    类是引用类型
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

/**
    恒等运算符
 */

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
