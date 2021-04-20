//
//  main.swift
//  Swift-基本运算符
//
//  Created by 王潇 on 2021/3/25.
//

import Foundation

/**
    赋值运算符
 */

let b = 10
var a = 5
a = b

let (x, y) = (1, 2)

/**
    算术运算符
 */

let add = 1 + 2
let subtract = 5 - 3
let multiply = 2 * 3
let divide = 10.0 / 2.5

/**
    一元负号运算符
 */

let three = 3
let minusThree = -three //  minusThree
let plusThree = -minusThree //  plusThree

/**
    一元正号运算符
 */

let minusSix = -6
let alsoMinusSix = +minusSix    //  alsoMinusSix 等于 -6

/**
    组合赋值运算符
 */

var aNum = 1
aNum += 2
//  a现在是3

/**
    比较运算符(Comparison Operators)
 */

let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

/**
    空运算符
 */

//a != nil ? a! : b

let defaultColorName = "red"
var userDefinedColorName: String?   //  默认值为nil

var colorNameToUse = userDefinedColorName ?? defaultColorName

/**
    区间运算符
 */

//  闭区间运算符 ...

for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

//  半开区间运算符 ..<

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第 \(i + 1)个人叫 \(names[i])")
}

//  单侧区间
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}

for name in names[..<2] {
    print(name)
}

let range = ...5
range.contains(7)
range.contains(4)
range.contains(-1)

/**
    逻辑运算符
 */

//  逻辑非 ( !a )
//  逻辑与 ( a && b )
//  逻辑或 ( a || b )

/**
    逻辑非运算符
 */

let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}

//  输出"ACCESS DENIED"

/**
    逻辑与运算符
*/

//let enteredDoorCode = true
//let passedRetinaScan = false
//if enteredDoorCode && passedRetinaScan {
//    print("Welcome!")
//} else {
//    print("ACCESS DENIED")
//}

/**
    逻辑或与运算符
 */

let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

//  输出 "ACCESS DENIED"

/**
    逻辑运算符组合计算
 */

//if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
//    print("Welcome!")
//} else {
//    print("ACCESS DENIED")
//}


/**
    使用括号来明确优先级
 */

//if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
//    print("Welcome!")
//} else {
//    print("ACCESS DENIED")
//}
