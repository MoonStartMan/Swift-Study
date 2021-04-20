//
//  main.swift
//  Swift-内存安全
//
//  Created by 王潇 on 2021/4/9.
//

import Foundation

//  默认情况下，Swift会阻止你代码里不安全的行为。例如，Swift会保证变量在使用之前就完成初始化，在内存被回收之后就无法被访问，并且数组的索引会做越界检查。

//  Swift也保证同时访问同一块内存时不会冲突，通过约束代码里对于存储地址的写操作，去获取那一块内存的访问独占权。因为Swift自动管理内存，所以大部分时候你完全不需要考虑内存访问的事情。然而，理解潜在的冲突也是很重要的，可以避免你写出访问冲突的代码。而如果你的代码确实存在冲突，那在编译时或者运行时就会得到错误。

/**
    理解内存访问冲突
 */

//  内存的访问，会发生在你给变量赋值，或者传递参数给函数时。例如，下面的代码就包含了读和写的访问:


//  向 one 所在的内存区域发起一次写操作
var one = 1

//  向 one 所在的内存区域发起一次读操作

print("We're number \(one)!")

//  内存访问的冲突会发生在你的代码尝试同时访问同一个存储地址的时候。同一个存储地址的多个访问同时发生会造成不可预计或不一致的行为。在Swift里，有很多修改值的行为都会持续好几行代码，在修改值的过程中进行访问是有可能发生的。

/**
    内存访问性质
 */

//  内存访问冲突时，要考虑内存访问上下文中的这三个性质：访问是读还是写，访问的时长，以及被访问的存储地址。特别是，冲突会发生在当你有两个访问符合下列的情况：
//  至少有一个是写访问
//  它们访问的是同一个存储地址
//  它们的访问在时间线上部分重叠

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1

myNumber = oneMore(than: myNumber)
print(myNumber)


/**
    In-Out 参数的访问冲突
 */

var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

increment(&stepSize)

//  错误: stepSize 访问冲突

//func increment(_ number: inout Int){
//    number += stepSize
//}

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)   // 正常
balance(&playerOneScore, &playerTwoScore)   // 错误: playerOneScore 访问冲突

/**
    方法里 self 的访问冲突
 */

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

//  在上面的 restoreHealth() 方法里，一个对于 self 的写访问从方法开始直到方法return。在这种情况下，restoreHealth() 里的其它代码不可以对 Player 实例的属性发起重叠的访问。下面的 shareHealth(with:) 方法接受另一个 Player 的实例操作为 in-out 参数,产生了访问重叠的可能性。

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria) //  正常

/**
    属性的访问冲突
 */

var playerInformation = (health: 10, energy: 20)
//balance(&playerInformation.health, playerInformation.energy)
//  错误: playerInformation 的属性访问冲突

var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)   //  错误

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)   //  正常
}

