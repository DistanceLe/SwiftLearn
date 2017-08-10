//
//  ViewController.swift
//  入门1.3
//
//  Created by LiJie on 16/4/12.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //控制流：
        
        //Swift 的switch语句比 C 语言中更加强大,Swift 无需写break，所以不会发生这种贯穿的情况。case 还可以匹配更多的类型模式，包括区间匹配（range matching），元组（tuple）和特定类型的描述。switch的 case 语句中匹配的值可以是由 case 体内部临时的常量或者变量决定，也可以由where分句描述更复杂的匹配条件。
        
        for _ in 1...5 {
            print("come in")
            print("mya ias teast", separator: "a", terminator: "-")
            print("test two string", separator: " ")
            debugPrint("this is debug")
        }
        
        var whileCondition = 10
        
        while whileCondition>0 {
            print("is whileCondition")
            whileCondition -= 1
        }
        
        //虽然在Swift中break不是必须的，但你依然可以在 case 分支中的代码执行完毕前使用break跳出
        //每一个 case 分支都必须包含至少一条语句。
        let someCharacter: Character = "e"
        
        switch someCharacter {
            
        case "a", "e", "i", "o", "u":
//            break
            print ("\(someCharacter) is a vowel")
            
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        // 输出 "e is a vowel"
        
        
        //Swift 允许多个 case 匹配同一个值。实际上，在这个例子中，点(0, 0)可以匹配所有四个 case。但是，如果存在多个匹配，那么只会执行第一个被匹配到的 case 分支
        //可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（ _ ）来匹配所有可能的值。
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        // 输出 "(1, 1) is inside the box"
        
        
        //值绑定（Value Bindings）
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y)://匹配余下所以的
            print("somewhere else at (\(x), \(y))")
        }
        // 输出 "on the x-axis with an x value of 2"
        
        
        //case 分支的模式可以使用where语句来判断额外的条件。
        let yetAnotherPoint = (2, -2)
        
        switch yetAnotherPoint {
            
        case let(x, y) where x == y:
            print("x==y", x, y)
        case let(x, y) where x == -y:
            print("x==-y", x, y)
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        //Swift 有五种控制转移语句：
        /*
        continue
        break
        fallthrough
        return
        throw*/
        // 当一个switch分支仅仅包含注释时，会被报编译时错误。注释不是代码语句而且也不能让switch分支达到被忽略的效果。你总是可以使用break来忽略某个分支。
        
        //贯穿（Fallthrough）
        //你可以在每个需要该特性的 case 分支中使用fallthrough关键字,使之成为C语言的风格
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        // 输出 "The number 5 is a prime number, and also an integer."
        
        
        //带标签的语句
        //显式地指明break语句想要终止的是哪个循环体或者switch代码块
        //显式指明continue语句想要影响哪一个循环体
        //产生一个带标签的语句是通过在该语句的关键词的同一行前面放置一个标签，并且该标签后面还需带着一个冒号。下面是一个while循环体的语法，同样的规则适用于所有的循环体和switch代码块。
        testLoop: while 2>0{
            break testLoop
        }
        
        //提前退出
        //我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。不同于if语句，一个guard语句总是有一个else分句，如果条件不为真则执行else分句中的代码。
        guard 3>0 else{
            
        }
        
        
        //检测 API 可用性
        if #available(iOS 10, OSX 10.10, watchOS 3, *) {
            //在ios 和 osx 分别使用 10 和 10.10 的api
        }else{
            //使用其他的api
        }
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

