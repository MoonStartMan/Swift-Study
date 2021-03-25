//
//  main.swift
//  Swift-字符串和字符
//
//  Created by 王潇 on 2021/3/25.
//

import Foundation

/**
    字符串字面量
 */

let someString = "Some string literal value"

/**
    多行字符串面量
 */

let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

let singlelineString = "These are the same."
let multilineString = """
These are the same.
"""

let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""

/**
    字符串字面量的特殊字符
 */

/**
    \0(空字符)  \\(反斜线)  \t(水平制表线)  \n(换行符)  \r(回车符)  \"双引号 \'单引号
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
//print("I \(sparklingHeart) U" )

/**
    扩展字符串分隔符
 */

let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#

/**
    初始化空字符串
 */

var emptyString = ""    //  空字符串面量
var anotherEmptyString = String()   //  初始化方法
//  两个自飞船均为空并等价

//  通过检查Bool类型的isEmpty属性来判断该字符串是否为空
if emptyString.isEmpty {
//    print("Nothing to see here")
}

/**
    字符串可变性
 */

var variableString = "Horse"
variableString += "and carriage"

/**
    使用字符
 */

for character in "Dog!" {
//    print(character)
}

/**
    通过声明一个 Character
 */
//let exclamationMark: Character = "!"


/**
    连接字符串和字符
 */

let string1 = "hello"
let string2 = "there"
//var welcome = string1 + string2

var instruction = "look over"
instruction += string2

let exclamationMark: Character = "!"
//welcome.append(exclamationMark)

let badStart = """
one
two
"""

let end = """
three
"""

//print(badStart + end)
//  打印两行
//  one
//  twothree

let goodStart = """
one
two
"""

//print(goodStart + end)
//  打印三行:
//  one
//  two
//  three

/**
    字符串插值
 */

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

/**
 字符串索引
 */
//let greeting = "Guten Tag!"

//print(greeting[greeting.startIndex])
//print(greeting[greeting.endIndex])
//print(greeting[greeting.index(before: greeting.endIndex)])
//print(greeting[greeting.index(after: greeting.startIndex)])
//let index = greeting.index(greeting.startIndex, offsetBy: 7);

//greeting[greeting.endIndex] //  会越界
//greeting.index(after: greeting.endIndex)    //  越界

//  使用 indices 属性会创建一个包含全部索引的范围( Range ),用来在一个字符串中访问单个字符。
//for index in greeting.indices {
//    print("\(greeting[index])", terminator: "")
//}

/**
    插入和删除
 */

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)

welcome.insert(contentsOf: "there", at: welcome.index(before: welcome.endIndex))
welcome.remove(at: welcome.index(before: welcome.endIndex))

/**
    子字符串
 */

let greeting = "Hello, world"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]

//  把结果转化为 String 以便长期存储。
let newString = String(beginning)

/**
    比较字符串
 */

//let quotation = "We 're a lot alike, you and I."
//let sameQuotation = "We 're a lot alike, you and I."
//if quotation == sameQuotation {
//    print("These two strings are considered equal")
//}

/**
    前缀/后缀相等
 */

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}

print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
