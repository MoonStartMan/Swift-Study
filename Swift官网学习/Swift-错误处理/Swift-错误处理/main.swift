//
//  main.swift
//  Swift-错误处理
//
//  Created by 王潇 on 2021/4/1.
//

import Foundation

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFounds(coinsNeeded: Int)
    case outOfStock
}

//  throw VendingMachineError.insufficientFounds(coinsNeeded: 5)

/**
    处理错误
 */


/**
    用 throwing 函数传递错误
 */
//func canThrowErrors() throws -> String

//func cannotThrowErrors() -> String

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFounds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoritesSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/**
    用 Do-Catch 处理错误
 */

//var vendingMachine = VendingMachine()
//vendingMachine.coinsDeposited = 8
//do {
//    try buyFavoritesSnack(person: "Alice", vendingMachine: vendingMachine)
//    print("Success! Yum.")
//} catch VendingMachineError.invalidSelection {
//    print("Invalid Selection.")
//} catch VendingMachineError.outOfStock {
//    print("Out of Stock.")
//} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
//    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
//} catch {
//    print("Unexpected error: \(error).")
//}

//func nourish(with item: String) throws {
//    do {
//        try VendingMachine.vend(itemNamed: item)
//    } catch is VendingMachineError {
//        print("Invalid selection, out of stock, or not enough money.")
//    }
//}
//
//do {
//    try nourish(with: "Beet-Flavored Chips")
//} catch {
//    print("Unexpected non-vending-machine_related error: \(error)")
//}

/**
    将错误转换成可选值
 */

//func someThrowingFunction() throws -> Int {
//    //  ...
//}
//
//let x = try? someThrowingFunction()
//
//let y: Int?
//do {
//    y = try someThrowingFunction()
//} catch {
//    y = nil
//}

//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}

/**
    禁用错误传递
 */

//let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

/**
    指定清理操作
 */

//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // 处理文件。
//        }
//        // close(file) 会在这里被调用，即作用域的最后。
//    }
//}
