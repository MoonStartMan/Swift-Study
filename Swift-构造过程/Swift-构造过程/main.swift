//
//  main.swift
//  Swift-构造过程
//
//  Created by 王潇 on 2021/3/30.
//

import Foundation

/**
    存储属性的初始赋值
 */

//  构造器
    //init() {
        //  在此处执行构造过程
    //}

struct Fahreheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

var f = Fahreheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

/**
    默认属性值
 */

//如前所述,你可以在构造器中为存储型属性设置初始值。同样，你可以在属性声明时为其设置默认值。
struct Fahrenheit {
    var temperature = 32.0
}

/**
    自定义构造过程
 */

//  形参的构造过程
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//  oilingPointOfWater.temperatureInCelsius 是 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//  freezingPointOfWater.temperatureInCelsius 是 0.0

/**
    形参命名和实参标签
 */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//let veryGreen = Color(0.0, 1.0, 0.0)    //  报编译期错误-需要实参标签

/**
    不带实参标签的构造器形参
 */

//struct Celsius {
//    var temperatureInCelsius:Double
//    init(fromFahrenheit fahrenheit: Double) {
//        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
//    }
//    init(fromKelvin kelvin: Double) {
//        temperatureInCelsius = kelvin - 273.15
//    }
//    init(_ celsius: Double) {
//        temperatureInCelsius = celsius
//    }
//}
//
//let bodyTemperature = Celsius(37.0)

/**
    可选属性类型
 */
class SurveryQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveryQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
//  打印 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."

/**
    构造过程中常量属性的赋值
 */

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveryQuestion(text: "How about beets?")
beetsQuestion.ask()
//  打印"How about beets"
beetsQuestion.response = "I also like beets. (But not with cheee.)"

/**
    默认构造器
 */
//class ShoppingListItem {
//    var name: String?
//    var quantity = 1
//    var purchased = false
//}
//var item = ShoppingListItem()


/**
    结构体的逐一成员构造器
 */

//struct Size {
//    var width = 0.0, height = 0.0
//}
//let twoByTwo = Size(width: 2.0, height: 2.0)

/**
    值类型的构造器代理
 */

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init (center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()

let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

/**
    类的继承和构造过程
 */


/**
    指定构造器和便利构造器
 */

//init(parameters) {
//    statements
//}

//  便利构造器在init关键字之前放置 convenience 关键字
//convenience init(parameters) {
//    statements
//}

/**
    类类型的构造器代理
 */

//  规则1：指定构造器必须调用其直接父类的指定构造器
//  规则2：便利构造器必须调用同类中定义的其它构造器
//  规则3：便利构造器最后必须调用指定构造器


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        //  super.init() 在这里被隐式调用
    }
    
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
//  Hoverboard: 0 wheel(s) in a beautiful silver

/**
    构造器的自动继承
 */

/**
    指定构造器和便利构造器实践
 */

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

/**
    可失败构造器
 */
