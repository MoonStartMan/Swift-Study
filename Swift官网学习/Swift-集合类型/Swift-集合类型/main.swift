//
//  main.swift
//  Swift-集合类型
//
//  Created by 王潇 on 2021/3/26.
//

import Foundation

var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)
print(someInts)
someInts = []
print(someInts)

/**
    创建一个带有默认值的数组
    repeating:
 */
var threeDoubles = Array(repeating: 0.0, count: 3)

/**
    通过两个数组相加创建一个数组
 */

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles

/**
    用数组字面量构造数组
 */

var shoppingList: [String] = ["Eggs", "Milk"]
//  shoppingList 已经被构造并且拥有两个初始项


/**
    访问和修改数组
 */

print("The shopping list contains \(shoppingList.count).items.")

//  isEmpty作为一个缩写形式去检查 count 属性是否为 0
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

shoppingList.append("Flour");

shoppingList += ["Baking Powder"]

shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

var firstItem = shoppingList[0]

shoppingList[0] = "Six eggs"

shoppingList[4...6] = ["Bananas", "Apples"]

shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)

firstItem = shoppingList[0]

let apples = shoppingList.removeLast()

/**
    数组的遍历
 */

for item in shoppingList {
    print(item)
}

/**
    需要每项的值和索引,可以用enumerated()方法进行数组遍历。
 */

for (index, value) in shoppingList.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}

/**
    集合类型语法
 */

//  创建和构造一个空的集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")
letters = []

/**
    用数组字面量创建集合
 */

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

// 访问和修改一个集合
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

/**
    遍历集合
 */

for genre in favoriteGenres {
    print("\(genre)")
}

/**
    集合操作
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

print(oddDigits.union(evenDigits).sorted())
print(oddDigits.intersection(evenDigits).sorted())
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())

//  使用"是否相等"运算符(==)来判断两个集合是否包含全部相同的值。
//  使用 isSubset(of:) 方法来判断一个集合中的值是否也被包含在另一个集合中
//  使用 isSuperset(of:) 方法来判断一个集合中包含另一个集合中所有的值
//  使用 isStrictSubset(of:)或者 isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等
//  使用 isDisjonit(with:) 方法来判断两个集合是否不含有相同的值(是否没有交集)

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

print(houseAnimals.isSubset(of: farmAnimals))

print(farmAnimals.isSuperset(of: houseAnimals))

print(farmAnimals.isDisjoint(with: cityAnimals))

/**
    字典
 */

//  创建一个空字典
var namesOfIntegers = [Int: String]()

namesOfIntegers[16] = "sixteen"

namesOfIntegers = [:]

/**
    用字典字面量创建字典
 */

var airports: [String: String] = ["YYZ": "Toronto Person", "DUB": "Dublin"]

/**
    访问和修改字典
 */

print("The dictionary of airports contains \(airports.count) items.")

if airports.isEmpty {
    print("The airports dictionary is empty")
} else {
    print("The airports dictionary is not empty")
}

airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"

if let oldValue = airports.updateValue("Doblin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName)")
} else {
    print("That airport is not in the airports dictionary.")
}

airports["APL"] = "Apple Internation"

airports["APL"] = nil

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

/**
    字典遍历
 */
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)

let airpotNames = [String](airports.values)
