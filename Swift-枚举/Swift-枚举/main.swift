//
//  main.swift
//  Swift-枚举
//
//  Created by 王潇 on 2021/3/27.
//

import Foundation

enum SomeEnumeration {
    //  枚举定义放在这里
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west

directionToHead = .east

/**
    使用 switch 语句匹配枚举值
 */
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

/**
    枚举成员的遍历
 */

enum Beverage: CaseIterable{
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}
//  coffee
//  tea
//  juice

/**
    关联值
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}

/**
    原始值
 */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/**
    原始值的隐示赋值
 */

//enum Planet: Int {
//    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
//}

//enum CompassPoint: String {
//    case north, south, east, west
//}

/**
    使用原始值初始化枚举实例
 */

//let positionToFind = 11
//if let somePlanet = Planet(rawValue: positionToFind) {
//    switch somePlanet {
//        case .earth:
//            print("Mostly harmless")
//        default:
//            print("Not a safe place for humans")
//    }
//} else {
//    print("There isn't a planet at position \(positionToFind)")
//}

/**
    递归枚举
 */

//enum ArithmeticExpression {
//    case number(Int)
//    indirect case addition(ArithmeticExpression, ArithmeticExpression)
//    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//}

//  indirect 关键字来表明它的所有成员都是可以递归的
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
