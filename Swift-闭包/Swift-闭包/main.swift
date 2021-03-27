//
//  main.swift
//  Swift-闭包
//
//  Created by 王潇 on 2021/3/27.
//

import Foundation

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward(_:_:))

//  闭包写法
//reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
//    return s1 > s2
//})

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

/**
    根据上下文推断类型
 */

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 })

/**
    单表达式闭包的隐式返回
 */

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 })

/**
    参数名称缩写
 */

reversedNames = names.sorted(by: { $0 > $1 })

reversedNames = names.sorted(by: >)

/**
    尾随闭包
 */

func someFunctionThatTakesAClosure(closure: () -> Void) {
    //  函数体部分
}

//  不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure {
    //  闭包主体部分
}

//  以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    //  闭包主体部分
}

reversedNames = names.sorted { $0 > $1}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map {
    (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}

/**
    值捕获
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

print(incrementByTen())
print(incrementByTen())
print(incrementByTen())

let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())

/**
    闭包是引用类型
 */

let alsoIncurementByTen = incrementByTen
print(alsoIncurementByTen())

/**
    逃逸闭包
 */

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)

/**
    自动闭包
 */

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
//  打印出"5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
//  打印出"5"

print("Now serving \(customerProvider())!")
print(customersInLine.count)
//  打印出"4"

func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
//  打印出"Now serving Alex"

//  customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))

var customerProviders: [() -> String] = []
func collectCtstomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCtstomerProviders(customersInLine.remove(at: 0))
collectCtstomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
//  打印"Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}

