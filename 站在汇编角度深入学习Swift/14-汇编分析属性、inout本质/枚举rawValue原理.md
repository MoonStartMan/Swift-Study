# 枚举rawValue原理

枚举原始值rawValue的本质是：只读计算属性

``` swift

enum Season: Int {
    case test1 = 1, test2 = 2, test3 = 3
    var rawValue: Int {
        switch self {
        case .test1:
            return 10
        case .test2:
            return 11
        case .test3:
            return 12
        }
    }
}

print(TestEnum.test3.rawValue)	//	12

```