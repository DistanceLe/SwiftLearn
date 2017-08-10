//
//  ViewController.swift
//  入门2.2-枚举
//
//  Created by LiJie on 16/4/13.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //枚举
        enum someEnumeration{
            //枚举定义放在这里
        }
        
        //枚举中定义的值（如 North，South，East和West）是这个枚举的成员值（或成员）。你使用case关键字来定义一个新的枚举成员值。
        //与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中，North，South，East和West不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
        enum CompassPoint {
            case North
            case South
            case East
            case West
        }
        
        var directionToHead = CompassPoint.East
        //一旦directionToHead被声明为CompassPoint类型，你可以使用更简短的点语法将其设置为另一个CompassPoint的值
        directionToHead = .North
        
        switch directionToHead {
        case .East:
            break
        case .North:
            break
        case .South:
            break
        case .West:
            break
            
        }
        
        //定义一个名为Barcode的枚举类型，它的一个成员值是具有(Int，Int，Int，Int)类型关联值的UPCA，另一个成员值是具有String类型关联值的QRCode。
        enum Barcode {
            case UPCA(Int, Int, Int, Int)
            case QRCode(String)
        }
        
        var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
        
        switch productBarcode {
        case .UPCA(let numberSystem, let manufacturer, let product, let check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .QRCode(let productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
        
        //如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，为了简洁，你可以只在成员名称前标注一个let或者var：
        switch productBarcode {
        case let .UPCA(numberSystem, manufacturer, product, check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case let .QRCode(productCode):
            print("QR code: \(productCode).")
        }
        // 输出 "QR code: ABCDEFGHIJKLMNOP."
        
        
        //原始值和关联值是不同的。原始值是在定义枚举时被预先填充的值，像上述三个 ASCII 码。对于一个特定的枚举成员，它的原始值始终不变。关联值是创建一个基于枚举成员的常量或变量时才设置的值，枚举成员的关联值可以变化。
        
        //原始值（Raw Values）
        //在关联值小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
        
        enum ASCIIControlCharacter: Character {
            case Tab = "\t"
            case LineFeed = "\n"
            case CarriageReturn = "\r"
        }
        
       
        
        //原始值的隐式赋值（Implicitly Assigned Raw Values）
        //在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
        
        //例如，当使用整数作为原始值时，隐式赋值的值依次递增1。如果第一个枚举成员没有设置原始值，其原始值将为0
        enum Planet: Int {
            case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
        }
        
        //CompassPoint.South拥有隐式原始值South，依次类推。
        enum CompassPoint2: String {
            case North, South, East, West
        }
        
        //使用枚举成员的rawValue属性可以访问该枚举成员的原始值：
        let earthsOrder = Planet.Earth.rawValue
        // earthsOrder 值为 3
        
        let sunsetDirection = CompassPoint2.West.rawValue
        // sunsetDirection 值为 "West"
        
        
        
        //使用原始值初始化枚举实例（Initializing from a Raw Value）
        //这个例子利用原始值7创建了枚举成员Uranus：
        let possiblePlanet = Planet(rawValue: 7)
        // possiblePlanet 类型为 Planet? 值为 Planet.Uranus
        //如果你试图寻找一个位置为9的行星，通过原始值构造器返回的可选Planet值将是nil：
        //原始值构造器是一个可失败构造器，因为并不是每一个原始值都有与之对应的枚举成员
        
        
        //递归枚举（Recursive Enumerations）
        //你也可以在枚举类型开头加上indirect关键字来表明它的所有成员都是可递归的：
        //        indirect enum ArithmeticExpression {
        //            case Number(Int)
        //            case Addition(ArithmeticExpression, ArithmeticExpression)
        //            case Multiplication(ArithmeticExpression, ArithmeticExpression)
        //        }
        //递归枚举（recursive enumeration）是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。
        
        enum ArithmeticExpression {
            case Number(Int)
            
            indirect case Addition(ArithmeticExpression, ArithmeticExpression)
            indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        func evaluate(expression: ArithmeticExpression) -> Int {
            switch expression {
            case .Number(let value):
                return value
            case .Addition(let left, let right):
                return evaluate(expression: left) + evaluate(expression: right)
            case .Multiplication(let left, let right):
                return evaluate(expression: left) * evaluate(expression: right)
            }
        }
        
        // 计算 (5 + 4) * 2
        let five = ArithmeticExpression.Number(5)
        let four = ArithmeticExpression.Number(4)
        let sum = ArithmeticExpression.Addition(five, four)
        let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
        print(evaluate(expression: product))
        // 输出 "18"
        
        
        
        
        
    }


}

