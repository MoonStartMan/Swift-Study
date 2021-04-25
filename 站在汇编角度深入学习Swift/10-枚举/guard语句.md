# guard语句

``` swift
guard 条件 else {
	//	do something....
	退出当前作用域
	//	return、break、continue、throw error
}

```

+ 当guard语句的条件为false时,就会执行大括号里面的代码
+ 当guard语句的条件为true时,就会跳过guard语句
+ guard语句特别适合用来"提前退出"
+ 当使用guard语句进行可选项绑定时，绑定的常量(let)、变量(var)也能在外层作用域中使用

``` swift

func login(_ info: [String : String]) {
	guard let username = info["username"] else {
		print("请输入用户名")
		return
	}
	guard let password = info["password"] else {
		print("请输入密码")
		return
	}
	//	if username ....
	//	if password	....
	print("用户名: \(username)", "密码: \(password)", "登陆ing")
}

```

