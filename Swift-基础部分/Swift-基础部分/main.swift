//
//  main.swift
//  Swift-基础部分
//
//  Created by 王潇 on 2021/3/25.
//

import Foundation

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

print("The current value of friendlyWelcome is \(friendlyWelcome)")

let minValue = UInt8.min    //  minValue 为 0, 是 UInt8 类型
let maxValue = UInt8.max    //  maxValue 为 255, 是UInt8 类型

//let cannotBeNegative: UInt8 = -1
//  UInt8 类型不能存储负数，所以会报错
//let tooBig: Int8 = Int8.max + 1
//  Int8 类型不能存储超过最大值的数，所以会报错

let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
//  pi 等于 3.14159，所以推测为 Double 类型

//  类型别名:就是给现有类型定义另一个名字。你可以使用 typealias 关键字来定义类型别名。

typealias AudioSample = UInt16

var maxAmplitudeFonud = AudioSample.min

let orangesAreOrange = true
let turnipsAreDelicious = false

if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

let http404Error = (404, "Not Found")
//  http404Error的类型是 (Int, String), 值是(404, "Not Found")

let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")

print("The status message is \(statusMessage)")

let http200Status = (statusCode: 200, description: "OK")

print("The status code is \(http200Status.statusCode)")

print("The status message is \(http200Status.description)")

var serverResponseCode: Int? = 404

serverResponseCode = nil

var surveyAnswer: String?

if serverResponseCode != nil {
    print("convertedNumber contains some integer value")
}

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

if let firstnumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstnumber < secondNumber && secondNumber < 100 {
            print("\(firstnumber) < \(secondNumber) < 100")
        }
    }
}

let possibleString: String? = "An optional string."
//let forcedString: String = possibleString

let assumedString: String! = "An implicity unwrapped optional string."
let implicitString: String = assumedString

if assumedString != nil {
    print(assumedString!)
}

if let definiteString = assumedString {
    print(definiteString)
}
