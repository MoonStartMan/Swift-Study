//
//  main.swift
//  Swift-泛型
//
//  Created by 王潇 on 2021/4/7.
//

import Foundation

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  这个函数使用输入输出函数( inout )来交换 a 和 b 的值
//  swapTwoInts(_:_:)函数将 b 的原始值换成了 a ,将 a 的原始值换成了 b ,你可以调用这个函数来交换两个 Int 类型变量:

//var someInt = 3
//var anotherInt = 107
//swapTwoInts(&someInt, &anotherInt)
//print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  swapTwoInts(_:_:) 函数很实用，但它只能作用于 Int 类型。如果你想交换两个 String 类型值，或者 Double 类型值，你必须编写对应的函数，类似下面 swapTwoStrings(_:_:) 和 swapTwoDoubles(_:_:) 函数：

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)

/**
    泛型类型
 */

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//struct Stack<Element> {
//    var items = [Element]()
//    mutating func push(_ item:Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}

//  Element 在如下三个地方被用作占位符：
//  * 创建 items 属性,使用 Element 类型的空数组对其进行初始化。
//  * 指定 push(_:) 方法的唯一参数 item 的类型必须是 Element 类型。
//  * 指定 pop 方法的返回值类型必须是 Element 类型。

//  由于 Stack 是泛型类型，因此可以用来创建适用于Swift中任意有效类型的栈,就像 Array 和 Dictionary 那样。
//  你可以通过在尖括号中写出栈中需要存储的数据类型来创建并初始化一个 Stack 实例。例如，要创建一个 String 类型的栈，可以写成 Stack<String>()

var stackOfStirngs = Stack<String>()
stackOfStirngs.push("uno")
stackOfStirngs.push("dos")
stackOfStirngs.push("tres")
stackOfStirngs.push("cuatro")

let fromTheTop = stackOfStirngs.pop()

/**
    泛型扩展
 */

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStirngs.topItem {
    print("The top item on the stack is \(topItem).")
}

/**
    类型约束
 */

//  swapTwoValues(_:_:) 函数和 Stack 适用于任意类型。不过,如果能对泛型函数或泛型函数或泛型类型中添加特定的类型约束，这将在某些情况下非常有用。类型约束指定类型参数必须继承自指定类、遵循特定的协议或协议组合。

/**
    类型约束语法
 */

//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//    //  这里是泛型函数的函数体部分
//}

//  上面这个函数有两个类型参数。第一个类型参数 T 必须是 SomeClass 子类; 第二个类型参数 U 必须符合 SomeProtocol 协议。

/**
    类型约束实践
 */

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//findIndex(ofString: , in: ) 函数可以用于查找字符串数组中的某个字符串值:

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//  打印"The index of llama is 2"

//  Swift标准库中定义了一个 Equatable 协议,该协议要求任何遵循该协议的类型必须实现等式符( == )及不等符( != ),从而能对该类型的任意两个值进行比较。所有的Swift标准类型自动支持 Equtable 协议。
//  遵循 Equatable 协议的类型都可以安全地用于 findIndex(of:in:) 函数,因为其保证支持等式操作符。为了说明这个事情，当定义了一个函数时，你可以定义一个 Equatable 类型约束作为类型参数定义的一部分：

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

//  findIndex(of:in:) 类型参数写做 T: Equatable,也就意味着"任何符合 Equatable 协议类型 T"。
//  findIndex(of:in:) 函数现在可以成功编译了,并且适用于任何符合 Equatable 的类型，如 Double 或 String:

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])

let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

/**
    关联类型
 */

//  定义了一个协议时,声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位符名称,其代表的实际类型在协议被遵循时才会被指定。关联类型通过 associatedtype 关键字来指定。

/**
    关联类型实践
 */

//  下面例子定义了一个 Container 协议,该协议定义了一个关联类型 Item :
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//  Container 协议定义了三个任何遵循该协议的类型(即容器)必须提供的功能:
//  必须可以通过 append(_:)方法添加了一个新元素到容器里
//  必须可以通过 count 属性获取容器中元素的数量,并返回一个Int值。
//  必须可以通过索引值类型为 Int 的下标检索到容器中的每一个元素

//struct IntStack: Container {
//    //  IntStack 的原始实现部分
//    var items = [Int]()
//    mutating func push(_ item: Int) {
//        items.append(item)
//    }
//    mutating func pop() -> Int {
//        return items.removeLast()
//    }
//    //  Container 协议实现的部分
//    typealias Item = Int
//    mutating func append(_ item: Int) {
//        self.push(item)
//    }
//    var count: Int {
//        return items.count
//    }
//    subscript(i: Int) -> Int {
//        return items[i]
//    }
//}

struct Stack<Element>: Container {
    //  Stack<Element>的原始实现部分
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }

    //  Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Element {
        return items[i]
    }
}

/**
    扩展现有类型来指定关联类型
 */

//  在扩展添加协议一致性 中描述了如何利用扩展让一个已存在的类型遵循一个协议,这包括使用了关联类型协议。

//extension Array: Container {}

/**
    给关联类型添加约束
 */

//protocol Container {
//    associatedtype Item: Equatable
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//}

//  要遵守 Container 协议, Item 类型也必须遵守 Equatable 协议。

/**
    在关联类型约束里使用协议
 */

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack: SuffixableContainer {
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return self
    }
    //  推断 suffix 结果是Stack
}
var stackOfInts = Stack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)

//extension IntStack: SuffixableContainer {
//    func suffix(_ size: Int) -> Stack<Int> {
//        var result = Stack<Int>()
//        for index in (count-size)..<count {
//            result.append(self[index])
//        }
//        return result
//    }
//    //  推断 suffix 结果是 Stack<Int>
//}

/**
    泛型 Where 语句
 */

func allItemsMath<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
    
        //  检查两个容器含有相同数的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
        //  检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    //  所有元素都匹配,返回true
    return true
}

var stackOfStrings = Stack<String>()
stackOfStirngs.push("uno")
stackOfStirngs.push("dos")
stackOfStirngs.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

//if allItemsMath(stackOfStirngs, arrayOfStrings) {
//    print("All items match.")
//} else {
//    print("Not all items match.")
//}

//  打印"All items match."

/**
    具有泛型 Where 子句的扩展
 */

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

//  打印"Top element is tres."

struct NotEquatable { }
var notEqutableStack = Stack<NotEquatable>()
let notEqutableValue = NotEquatable()
notEqutableStack.push(notEqutableValue)
//notEqutableStack.isTop(notEqutableValue)    //  报错

//  使用泛型 where 子句去扩展一个协议。基于以前的示例，下面的示例扩展了 Container 协议，添加一个 startsWith(_:) 方法。

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

//  这个 startsWith(_:) 方法首先确保容器至少有一个元素,然后检查容器中的第一个元素是否与给定的元素相等。任何符合 Container 协议的类型都可以使用这个新的 startsWith(_:) 方法,包括上面使用的栈和数组,只要容器的元素是符合 Equatable 协议的。

//if [9, 9, 9].startsWith(42) {
//    print("Starts with 42.")
//} else {
//    print("Starts with something else.")
//}

//  打印 "Starts with something else."

//extension Container where Item == Double {
//    func average() -> Double {
//        var sum = 0.0
//        for index in 0..<count {
//            sum += self[index]
//        }
//        return sum / Double(count)
//    }
//}
//
//print([1260.0, 1200.0, 98.6, 37.0].average())
//  打印 "648.9"

/**
    具有泛型 Where 子句的关联类型
 */

//protocol Container {
//    associatedtype Item
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//
//    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
//    func makeIterator() -> Iterator
//}

protocol ComparableContainer: Container where Item: Comparable { }


/**
    泛型下标
 */

extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
    where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

//  这个 Container 协议的扩展添加了一个下标方法，接收一个索引的集合,返回每一个索引所在的值的数组。这个泛型下标的约束如下:
//  在尖括号中的泛型参数 Indices,必须是符合标准库中的 Sequence 协议的类型。
//  下标使用的单一的参数, indices, 必须是 Indices 的实例。
//  泛型 where 子句要求 Sequence(Indices) 的迭代器, 其所有的元素都是 Int 类型。这样就能确保在序列( Sequence )中的索引和容器( Container )里面的索引类型是一致的。

//  综合一下, 这些约束意味着, 传入到 indices 下标, 是一个整形的序列。
