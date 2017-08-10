//
//  ViewController.swift
//  入门2.3-类和结构体
//
//  Created by LiJie on 16/4/13.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        struct Resolution {
            var width = 0
            var height = 0
        }
        
        class VideoMode {
            var resolution = Resolution()
            var interlaced = false
            var frameRate = 0.0
            var name: String = "ab"
            
            init (name: String){
                self.name = name
            }
        }
        
        //所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
        //类实例没有默认的成员逐一构造器
        let vga = Resolution(width:640, height: 480)
        print(vga.width);
        
        //结构体和枚举是值类型
        
        //值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        //实际上，在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        //示例中又声明了一个名为cinema的变量，并将hd赋值给它。因为Resolution是一个结构体，所以cinema的值其实是hd的一个拷贝副本，而不是hd本身。尽管hd和cinema有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例。
        cinema.width = 2048
        
        print("cinema is now  \(cinema.width) pixels wide")
        // 输出 "cinema is now 2048 pixels wide"
        
        print("hd is still \(hd.width) pixels wide")
        // 输出 "hd is still 1920 pixels wide"
        
        
        
        
        
        //类是引用类型
        
        //与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
        
        let tenEighty = VideoMode(name: "")
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        // 输出 "The frameRate property of theEighty is now 30.0"
        
        
        //需要注意的是tenEighty和alsoTenEighty被声明为常量而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate，因为tenEighty和alsoTenEighty这两个常量的值并未改变。它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值。
        
        
        //恒等运算符  能够判定两个常量或者变量是否引用同一个类实例
        /*等价于（===）
         不等价于（!==）*/
        if 1 == 0 {
            
        }
        
        if tenEighty === alsoTenEighty {
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        }
        //输出 "tenEighty and alsoTenEighty refer to the same Resolution instance."
        /*等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
         “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法*/
        
        
        
        
    }

    


}

