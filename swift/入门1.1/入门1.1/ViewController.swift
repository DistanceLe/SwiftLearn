//
//  ViewController.swift
//  入门1.1
//
//  Created by LiJie on 16/4/11.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //运算符：
        //1.在 Swift 中你可以对浮点数进行取余运算（%）
        //2.Swift 还提供了 C 语言没有的表达两数之间的值的区间运算符（a..<b 和 a...b）
        //3.Swift 的赋值操作并不返回任何值
        /*
         if x = y {
            // 此句错误, 因为 x = y 并不返回任何值
         }
         */
        
        //4.Swift 默认情况下不允许在数值运算中出现溢出情况。但是你可以使用 Swift 的溢出运算符来实现溢出运算（如 a &+ b）
        //5.加法运算符也可用于 String 的拼接
        //"hello, " + "world"  // 等于 "hello, world"
        
        //6.求余: -9 % 4   // 等于 -1
        //在对负数 b 求余时，b 的符号会被忽略。这意味着 a % b 和 a % -b 的结果是相同的。
        //浮点数求余计算  8 % 2.5   // 等于 0.5
        
        
        //7.复合赋值运算没有返回值，let b = a += 2这类代码是错误。这不同于自增和自减运算符
        //++ 或者 -- 有返回值。
        
        //8.Swift 也提供恒等（===）和不恒等（!==）这两个比较符来判断两个对象是否引用同一个对象实例
        
        //9.元组也可比较大小  Swift 标准库只能比较七个以内元素的元组比较函数。
        //(3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
        
        //10.空合运算符（Nil Coalescing Operator）
        
        /*  空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
            空合运算符是对以下代码的简短表达方法：
         
            a != nil ? a! : b
         */
        //求余数 a = 8 % 3.5 不能这么写了
        let a = 8.truncatingRemainder(dividingBy: 3.5)
        let b = 9.truncatingRemainder(dividingBy: 3.5)
        let c = 8.truncatingRemainder(dividingBy: 2.5)
        let str = "string"
        //let realStr :String = "abc"
        
        //let tempA=8%2
        
        //abc cc 1.0 2.0 0.5
        print("abc", "cc", a, b, c)
        
        print("abc\(a)")
        print("a\(str)bc",a)
        
        
        print(a,b,c)
        
        
        for index in 2...3 {
            print(index)
        }
        
        for index in 2..<5 {
            print(index)
        }
        
        
        //初始化空字符串 (Initializing an Empty String)
        // 两个字符串均为空并等价。
        let  emptyString = ""
        let  anotherEmptyString = String()
        print(emptyString, anotherEmptyString)
        
        //Swift 的String类型是值类型,其进行常量、变量赋值操作，或在函数/方法中传递时，会进行值拷贝。
        for character in "dog.gou".characters {
            
            print(character, "\n", "test")
        }
        
        //字符串可以通过传递一个值类型为Character的数组作为自变量来初始化：
        let  catCharacters: [Character] = ["c", "a", "t", "!"]
        let  catString = String(catCharacters)
        print(catString)
        
        var  subString = emptyString+catString
        var subString2 = "look"
        subString2 += emptyString
        print(subString, subString2)
        
        //您可以用append()方法将一个字符附加到一个字符串变量的尾部：
        let  exclamationMark: Character = "!"
        
        subString.append(exclamationMark)
        
        
        /*转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
         Unicode 标量，写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。*/
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imageination is more important than knowledge" - Enistein
        let dollarSign = "\u{24}"             // $, Unicode 标量 U+0024
        let blackHeart = "\u{2665}"           // ♥, Unicode 标量 U+2665
        let sparklingHeart = "\u{1F496}"      // 💖, Unicode 标量 U+1F496
        
        print(wiseWords)
        print(dollarSign)
        print(blackHeart)
        print(sparklingHeart)
        
        //索引
        let greeting = "guten tag!"
        print(greeting[greeting.startIndex])
        print(greeting[greeting.characters.index(before: greeting.endIndex)])
        print(greeting[greeting.characters.index(after: greeting.startIndex)])
        let index = greeting.characters.index(greeting.startIndex, offsetBy: 5)
        print(greeting[index])
        
//        greeting[greeting.endIndex]//会引发一个运行时错误，越界了。
        print(greeting.endIndex)
        print(greeting.startIndex)
        
        //使用characters属性的indices属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单个字符。
        for index in greeting.characters.indices {
            print(greeting[index], terminator: "")
        }
        
        var welcome = "HELLO"
        welcome.insert("!", at: welcome.endIndex)
        print(welcome)
        
        //HELLOworld!  HELLO!world
        welcome.insert(contentsOf: "world".characters , at: welcome.endIndex)
        print(welcome)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

