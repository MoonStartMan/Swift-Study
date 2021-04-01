//
//  main.swift
//  Swift-嵌套类型
//
//  Created by 王潇 on 2021/4/1.
//

import Foundation

/**
    嵌套类型实践
 */

struct BlackjackCard {
    
    //  嵌套 Suit 枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    //  嵌套 Rank 枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    //  BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue)"
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
}

/**
    引用嵌套类型
 */

let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
