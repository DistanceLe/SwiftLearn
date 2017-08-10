//
//  ViewController.swift
//  入门5.0-扩展
//
//  Created by LiJie on 16/4/18.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

extension Double{
    var mm:Double{ return self / 1_000.0 }
    
}

extension Int{
    
    //可变实例方法
    mutating func square(){
        self = self*self
    }
    
    //嵌套类型
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

private var personId = 0

extension Temp{
    var hello: String{
        get{
            var result = objc_getAssociatedObject(self, &personId) as? String
            if result == nil {
                return ""
            }
            return result!
        }
        set{
            objc_setAssociatedObject(self, &personId, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func sayHello() {
        print(hello, "everyOne")
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
        
        /*添加计算型属性和计算型类型属性
         定义实例方法和类型方法
         提供新的构造器
         定义下标
         定义和使用新的嵌套类型
         使一个已有类型符合某个协议*/
        
        let aMarathon = 24.km + 104.mm
        print("is ====\(aMarathon)")
        
        
        
        let defaultRect = Rect()
        let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
        
        
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        // centerRect 的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
        
        Temp().sayHello()
    
    }



}

