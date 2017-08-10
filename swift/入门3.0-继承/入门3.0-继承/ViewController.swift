//
//  ViewController.swift
//  入门3.0-继承
//
//  Created by LiJie on 16/4/15.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //定义一个基类（Base class）
        //Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为基类。
        class Vehicle {
            var currentSpeed = 0.0
            
            //description 为只读属性
            var description: String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            func makeNoise() {
                // 什么也不做-因为车辆不一定会有噪音
                print("no noise")
            }
        }
        
        //子类生成（Subclassing）
        class Bicycle: Vehicle{
            var hasBasket = false
            
            override func makeNoise() {
                print("bicycle ling ling ")
            }
        }
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle: \(bicycle.description)")
        bicycle.makeNoise()
        
        
        
        //你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性
        class Car: Vehicle{
            var gear = 1
            override var description: String{
                return super.description + "in gear \(gear)"
            }
            
            override var currentSpeed: Double{
                didSet {
                    gear = Int(currentSpeed/10) + 1
                }
            }
            
        }
        let car = Car()
        car.currentSpeed = 23.0
        car.gear = 3
        print(car.description)
        
        //防止重写
        //你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。
        //（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
        
    }


}

