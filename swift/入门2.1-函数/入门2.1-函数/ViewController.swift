//
//  ViewController.swift
//  入门2.1-函数
//
//  Created by LiJie on 16/4/12.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //内部函数：
        func sayHello(_ personName: String)->String{
            let greeting = "hello, "+personName+"!"
            return greeting
        }
        
        print(sayHello("LiJie"))
        
        
        func minMax(_ array:[Int])->(min: Int, max: Int)?{
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return nil
//            return (currentMin, currentMax)
        }
        
        let bounds=minMax([8, -6, 2, 109, 3, 71])
        
        let a = bounds?.min
        
        
        print("min=\(bounds?.min) max=\(bounds?.max)")
        
        
        //一般情况下，第一个参数省略其外部参数名，第二个以及随后的参数使用其局部参数名作为外部参数名。所有参数必须有独一无二的局部参数名。尽管多个参数可以有相同的外部参数名，但不同的外部参数名能让你的代码更有可读性。
        func someFunction(_ firstParam: Int, secondParam neibu:Int){
            print(neibu)
        }
        
//        someFunction(<#T##firstParam: Int##Int#>, secondParam: <#T##Int#>)
        //如果你不想为第二个及后续的参数设置外部参数名，用一个下划线（_）代替一个明确的参数名。
        func someFunction2(_ firstParam: Int, _ secondParam:Int){
            
        }
//        someFunction2(<#T##firstParam: Int##Int#>, <#T##secondParam: Int##Int#>)
        
        
        //默认参数值（Default Parameter Values）
        func someFunction3(_ firstParam: Int = 0)
        {
            print("参数值是 =\(firstParam)=")
        }
        
        someFunction3()// 默认是0
        someFunction3(3)//则是3
        
        
        //可变参数：variadic parameters
        //一个可变参数（variadic parameter）可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。通过在变量类型名后面加入（...）的方式来定义可变参数
        //如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后。
        func arithmeticMean(_ numbers: Double...)->Double{
            var total:Double = 0
            for number in numbers {
                total+=number
            }
            return total
        }
        
        print("totalis = ", arithmeticMean(1, 23, 4, 4))
        
        
        //常量参数和变量参数（Constant and Variable Parameters）
        func varParam(_ varParamString: String)->String{
            var varParamString = varParamString
            varParamString+="abc"
            return varParamString
        }
        //varParamString  可当做局部变量使用。
        
        
        //输入输出参数（In-Out Parameters）
        func inOutFunc(_ a:inout Int, _ b:inout Int){
            let tempA = a
            a=b
            b=tempA
        }
        
        var someInt = 4
        var anotherInt = 34
        //都加了 & 的前缀：
        inOutFunc(&someInt, &anotherInt)
        
        print("someInt=", someInt, "anotherInt=", anotherInt)
        
        //函数类型：
        //() -> Void，或者叫“没有参数，并返回 Void 类型的函数”。
        let mathFunction: (inout Int, inout Int) -> ()  = inOutFunc
        
        mathFunction(&someInt, &anotherInt)
        
        print("someInt=", someInt, "anotherInt=", anotherInt)
        
        //就像其他类型一样，当赋值一个函数给常量或变量时，你可以让 Swift 来推断其函数类型：
        let anotherFunc = inOutFunc
        anotherFunc(&someInt, &anotherInt)
        print("someInt=", someInt, "anotherInt=", anotherInt)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

