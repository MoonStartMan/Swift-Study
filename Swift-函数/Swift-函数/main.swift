//
//  main.swift
//  Swift-函数
//
//  Created by 王潇 on 2021/3/26.
//

import Foundation

/**
    函数的定义于调用
 */

func greet(person:String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "Anna"))

print(greet(person: "Brian"))

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

print(greetAgain(person: "Anna"))

/**
    函数参数与返回值
 */

//  无参数函数
func sayHelloWorld() -> String {
    return "hello, world"
}

print(sayHelloWorld())

//  多参数函数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

func printWithoutCounting(String: String) {
    let _ = printAndCount(string: String)
}

printAndCount(string: "Hello, world")

printWithoutCounting(String: "hello, world")

func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[1]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil}
    var currentMin = array[0]
    var currentMax = array[1]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}

func greeting(for person: String) -> String {
    "Hello, " + person + "!"
}

print(greeting(for: "Dave"))

func anotherGreeting(for person: String) -> String {
    return "Hello, " + person + "!"
}

print(anotherGreeting(for: "Dave"))

/**
    函数参数标签和参数名称
 */

func someFunction(firstParameterName: Int, secondParameterName: Int) {
    //  在函数体内, firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(firstParameterName: 1, secondParameterName: 2)

/**
    指定参数标签
 */

//func someFunction(argumentLabel, parameterName: Int) {
//    //  在函数体内, parameterName 代表参数值
//}

func greet(person: String, from hometown: String) -> String {
    return "Hello\(person)! Glad you could visit from \(hometown)."
}

print(greet(person: "Bill", from: "Cupertino"))

//  忽略参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    //  在函数体内, firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}

someFunction(firstParameterName: 1, secondParameterName: 2)

//  默认参数值
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    //  如果你在调用时候不传第二个参数, parameterWithDefault 会值为 12 传入到函数体中。
}

//  可变参数
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    
    return total / Double(numbers.count)
}

arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)

/**
    输入输出函数
 */

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  函数类型

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

func printHelloWorld() {
    print("hello, world")
}

//  使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)

//  函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts(_:_:), 3, 5)

//  函数类型作为返回类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward(_:) : stepForward(_:)
}


//  嵌套函数
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
