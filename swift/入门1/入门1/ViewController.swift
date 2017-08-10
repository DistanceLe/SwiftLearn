//
//  ViewController.swift
//  入门1
//
//  Created by celink on 15/8/3.
//  Copyright (c) 2015年 celink. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var frinedlyWelcome="hello"
        print("this is a String");
        
        //使用反斜线和小括号显示变量
        print("the current value of .. is", frinedlyWelcome)
        print("number \(13)...")

        /*
        Assertions 断言
        断言在运行时判断一个条件是否为true，使用断言来保证在运行其他代码的时候，某些重要条件已经得到满足，否则代码终止
        使用全局函数assert函数来写一个断言，给assert函数传入一个结果为true或false的表达式以及一条信息，当表达式为false的时候这条信息显示出来
        */
        let age = 3
        assert(age>=0, "年龄必须大于等于0")
        
        
        
        /*
        Range Operators 区间运算
        闭区间(a...b),定义了从a到b(包括a和b)区间内的所有值
        半闭区间(a..b),定义从a到b但不包括b的所有值，实用性在于当使用一个从0开始的数组，取数组的值
        */
        for index in 1...5
        {
            print("\(index) times 5 is \(index * 5)")
        }

        /*
        如果不知道区间内每一项的值，使用下划线 _ 来替代变量名去忽略
        不需要知道每一次循环中的具体值，只需知道需要循环的次数，使用下划线能够忽略具体的值，
        且不提供循环遍历时对值的访问
        */
        for _ in 0...age
        {
            print("test")
        }
        
        //遍历数组
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names
        {
            print("hello, \(name)")
        }
        
        //遍历字典
        //字典的每项以(key,value)元素组返回，在for-in循环中用显式的常量解读，因为字典是无序的，所以循环输出也是无序的
        let numberOfLegs = ["spider":8, "ant":6, "cat":4]
        for (animalName, legCount) in numberOfLegs
        {
            print("\(animalName)s have \(legCount) legs")
        }
        
        
        //常规 for循环
        for index in 0 ..< 3
        {
            print("index is \(index)")
        }
        
        //逻辑运算符
        let isTrue = true
        let isFalse = false
        
        //条件语句
        if 40 > 32
        {
            print("It's very big count")
        }
        else if 40 < 30
        {
            print("It's very small count")
        }

        
        
        switch "b"
        {
            case "b":
                print("is b")
                print("is bbb")
            case "a":
                print("is a")
            case "c":
                print("is c")
        default:
            print("is default")
        }
        
        
        //带标签的 语句
        //如果break语句没有使用标签，那将会中断switch而不是while，使用标签能清晰的表明break想要中断哪个循环
        var square = 0
        testLoop: while square != 25
        {
            square += 1
            switch square
            {
                
                case 25 : break testLoop
                default:
                    print("\(square)")
                    square += 1
            }
        }
        print("game over")
        
        
        //数组
        var shopingList:[String] = ["eggs", "milk"]
        var shopingLists=["eggs", "milks"]
        
        
        var someInts = [Int]()
        var threeDoubles = [Double](repeating: 4.5, count: 3)
        
        var anotherThreeDoubles = Array(repeating: 4.0, count: 4)
        
        
        if shopingList.isEmpty
        {
            print("is empty array")
        }
        shopingLists.append("flour")
        var firstItem=shopingLists[0]
        
        shopingLists[0]="new eggs"
        shopingLists[0...1] = ["banas", "apples"]
        shopingLists.insert("new styrup", at: 3)
        var removeItem = shopingLists.remove(at: 3)
        
        
        var sixDoubles = threeDoubles + anotherThreeDoubles
        
        print("\(shopingList), \(shopingLists), \(threeDoubles), \(anotherThreeDoubles), \(sixDoubles), \(removeItem)")
        
        //索引遍历数组
        for (index, value) in shopingLists.enumerated()
        {
            print("item \(index+1): \(value)")
        }
        
        for subString in shopingList {
            
            print(subString)
            
        }
        
        //字典 操作
        var airports: Dictionary<String, String> = ["tyo": "tokyo", "dub": "dublin"]
        
        airports["lhr"] = "london"
        
        
        
        
        /**
        函数
        
        - parameter personName: 参数
        
        - returns: 返回值字符串
        */
        
        func sayHelloAgain(personName: String) ->String
        {
            return "hello again," + personName + "!"
        }
        print(sayHelloAgain(personName: "Anna"))
        
        
        //如果希望在函数调用的时候使用函数提供的参数的名字，就需要再定义一个外部参数名，写在局部参数名之前，空格分开
        func join (string s1:String, tostring s2:String, withJoin joiner:String) -> String
        {
            return s1 + joiner + s2
        }
        
        print(join(string: "hh", tostring: "aa", withJoin: "jj"))
        
        //上一个的简写方式，在参数名前加(#)，告诉Swfit这个参数既作为外部参数，也作为局部参数
        func containschar(string: String, charToFind:Character) -> Bool
        {
            for char in string.characters
            {
                if char == charToFind
                {
                    return true
                }
            }
            return false
        }
        
        containschar(string: "slfjwofh", charToFind: "v")
        
        //可变 参数
        func arithmeticMean(numbers: Double...) ->Double
        {
            var total: Double = 0
            for number in numbers
            {
                total += number
            }
            return total / Double(numbers.count)
        }
        print(arithmeticMean(numbers: 1,2,3,4,5))
        
        //常量参数和变量参数
        //函数参数默认都是常量，想在函数体内更改参数值将会报错，但有时候，会在函数中有传入参数的变量值副本，通过指定一个或多个参数作为变量参数参数，从而避免在函数中定义新的变量，通过在参数名前加var来定义变量参数
        /*func alignRight(var string: String, counts: Int, pad: Character) -> String {
         let amountToPad = counts - string.characters.count
         for _ in 1...amountToPad
         {
         string.append(pad)
         }
         return string
         }*/
        
        func alignRight( string: String, counts: Int, pad: Character) -> String {
            var string = string
            let amountToPad = counts - string.characters.count
            for _ in 1...amountToPad
            {
                string.append(pad)
            }
            return string
        }
        let originalString = "hello"
        let paddedString = alignRight(string: originalString, counts: 10, pad: "-")
        // paddedString is equal to "-----hello"
        // originalString is still equal to "hello"
        print(originalString, paddedString)
        
        
        //输入输出参数
        //如果想要一个函数可以修改参数的值，并且这些修改在函数结束调用后仍然存在，那就可以定义为输入输出参数，在参数前面添加inout关键字，这个值被函数修改后被传出函数，并替换原来的值，同时，传入的只能是变量而不能是常量，当传入的参数作为作为输入输出参数时，需要在参数面前加 & 符号，表示这个值可以被修改
        func swapTwoInts( a: inout Int, b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(a: &someInt, b: &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        
        //.函数类型
        //每个函数都有特定的函数类型，由参数类型和返回类型组成
        func addTwoInts(a: Int, b: Int) -> Int {
            return a + b
        }
        func multiplyTwoInts(a: Int, b: Int) -> Int {
            return a * b
        }
        // 以上两个的函数类型是 (Int, Int) -> Int
        func printHelloWorld() {
            print("hello, world")  
        }  
        // 这个函数类型是 () -> ()
        
        //使用函数类型
        let mathFunction: (Int, Int) -> Int = addTwoInts
        print("Result: \(mathFunction(2, 3))")
        
        
        
        //元组
        //元组类型在作为函数返回值的时候特别适用，可以为函数返回更多的用户需要的信息。
        //元组类型可以将一些不同的数据类型组装成一个元素，这些数据类型可以是任意类型，并且不需要是同样的类型。
        let http404Error = (404, "Not Found")
        
        //访问一个元组：
        let  (statusCode, statusMessage) = http404Error
        print("the status code is", statusCode)
        print("the status Message is", statusMessage)
        
        //如果仅需要元组中的个别值，可以使用(_)来忽略不需要的值
        let ( _ , statusMessage2 ) = http404Error
        print("the status Message is", statusMessage2)
        
        //另外，也可以使用元素序号来选择元组中的值，注意序号是从0开始的
        print(http404Error.0, http404Error.1)
        
        //在创建一个元组的时候，也可以直接指定每个元素的名称，然后直接使用元组名.元素名访问，如：
        let http200Status = (statusCode: 200, description: "OK")
        print(http200Status.description)
        
        
        //可选类型 optionals
        //在一个值可能不存在的时候，可以使用可选类型。这种类型的定义是：要么存在这个值，且等于x，要么在这个值 不存在
        //一个可选的Int类型被记为Int?，不是Int。问号表明它的值是可选的，可能返回的是一个Int，或者返回的值不存在。
        
        //nil
        //你可以给可选变量赋值为nil来表示它没有值：
        var nilValue: Int? = 204
        print(nilValue)
        nilValue=nil
        print(nilValue)
        
        //if语句和强制解包
        //已经检测确认该值存在 只需要在名称后面加上感叹号(!)即可,意思是告诉编译器：我已经检测好这个值了，可以使用它了
        
        let convertedNumber :Bool? = 4>3
        let possibleNumber = 45
        
         if (convertedNumber != nil) {
            print("\(possibleNumber) has an integer value of \(convertedNumber!)")
         } else {
            print("\(possibleNumber) could not be converted to an integer")
         }
        //使用!来获取一个不存在的可选值会导致运行时错误。使用!来强制解析值之前，一定要确定可选包含一个非nil的值。
        
        
        //隐式解析可选类型 implicitly unwrapped optionals
        //把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。
        /*
         你可以把隐式解析可选类型当做一个可以自动解析的可选类型。你要做的只是声明的时候把感叹号放到类型的结尾，而不是每次取值的可选名字的结尾。
         
         注意：
         如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。
         
         注意：
         如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型。
         */
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // 需要惊叹号来获取值
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString  // 不需要感叹号
        
        //可选绑定
        //选绑定可以用在if和while语句中，这条语句不仅可以用来判断可选类型中是否有值，同时可以将可选类型中的值赋给一个常量或者变量
        /*
         if let constantName = someOptional {
            statements
         }*/
        
        //类型别名 type aliases
        typealias myType = UInt16
        let maxValue = myType.max
        print("maxValue=\(maxValue)")
        
        
        //错误处理 error handling
        func canThrowAnError() throws{
            //这个函数可能抛出错误
        }
        //一个函数可以通过在声明中添加throws关键词来抛出错误消息。当你的函数能抛出错误消息时, 你应该在表达式中前置try关键词。
        //一个do语句创建了一个新的包含作用域,使得错误能被传播到一个或多个catch从句。
        do{
            try canThrowAnError()
            //没有错误消息抛出
        }catch{
            //有一个错误消息抛出
        }
        
        /*
        func makeASandwich() throws {
            // ...
        }
        func eatASandwich(){
            
        }
        func washDishes(){
            
        }
        func buyGroceries(){
            
        }
        do {
            try makeASandwich()
            eatASandwich()
        } catch Error.OutOfCleanDishes {
            washDishes()
        } catch Error.MissingIngredients(let ingredients) {
            buyGroceries()
        }
         */
    }

}

