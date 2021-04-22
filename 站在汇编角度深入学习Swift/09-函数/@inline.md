# @inline

``` swift

//	永远不会被内联(即使开启了编译器优化)
@inline(nerver) func test() {
	print("test")
}

```

``` swift

//	开启编译器优化后，即使代码很长，也会被内联(递归调用函数、动态派发的函数除外)
@inline(__always) func test() {
	print("test")
}

```

在Release模式下，编译器已经开启优化，会自动决定哪些函数需要内联，因此没必要使用@inline