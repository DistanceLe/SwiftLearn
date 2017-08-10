//
//  ViewController.swift
//  入门4.0-引用计数
//
//  Created by LiJie on 16/4/15.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。
        class Person {
            let name: String
            var apartment: Apartment?
            init(name: String) {
                self.name = name
                print("\(name) is being initialized")
            }
            deinit {
                print("\(name) is being deinitialized")
            }
        }
        
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        reference1 = Person(name: "John Appleseed")
        reference2 = reference1
        reference3 = reference1
        reference1 = nil
        reference2 = nil
        reference3 = nil
        // 打印 “John Appleseed is being deinitialized”
        
        //类实例之间的循环强引用
        class Apartment {
            let unit: String
            init(unit: String) { self.unit = unit }
            var tenant: Person?
            deinit { print("Apartment \(unit) is being deinitialized") }
        }
        
        var john: Person?
        var unit4A: Apartment?
        
        john = Person(name: "John Appleseed")
        unit4A = Apartment(unit: "4A")
        
        john!.apartment = unit4A
        unit4A!.tenant = john
        
        //已经强引用了，不会被销毁
        john = nil
        unit4A = nil
        
        
        //解决实例之间的循环强引用
        //Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）。
        //对于生命周期中会变为nil的实例使用弱引用。相反地，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
        //弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
        //因为弱引用可以没有值，你必须将每一个弱引用声明为可选类型。在 Swift 中，推荐使用可选类型描述可能没有值的类型。
        class Apartment1 {
            let unit: String
            init(unit: String) { self.unit = unit }
            weak var tenant: Person?
            deinit { print("Apartment \(unit) is being deinitialized") }
        }
        
        
        //和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
        //由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
        //如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误
        class Customer {
            let name: String
            var card: CreditCard?
            init(name: String) {
                self.name = name
            }
            deinit { print("\(name) is being deinitialized") }
        }
        
        class CreditCard{
            let number: UInt16
            unowned let customer: Customer
            init(number: UInt16, customer: Customer){
                self.number=number
                self.customer=customer
            }
            deinit{
                print("CreditCard deinit cardNumber=", self.number)
            }
        }
        
        
        
        //无主引用以及隐式解析可选属性
        //两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
        //通过在类型结尾处加上感叹号（City!）的方式，将Country的capitalCity属性声明为隐式解析可选类型的属性。这意味着像其他可选类型一样，capitalCity属性的默认值为nil，但是不需要展开它的值就能访问它。
        //由于capitalCity默认值为nil，一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了。这意味着一旦name属性被赋值后，Country的构造函数就能引用并传递隐式的self。Country的构造函数在赋值capitalCity时，就能将self作为参数传递给City的构造函数。
        //意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
        
        class Country {
            let name: String
            var capitalCity: City!
            init(name: String, capitalName: String) {
                self.name = name
                self.capitalCity = City(name: capitalName, country: self)
            }
        }
        class City {
            let name: String
            unowned let country: Country
            init(name: String, country: Country) {
                self.name = name
                self.country = country
            }
        }
        
        //闭包引起的循环强引用
        //Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closure capture list）
        class HTMLElement {
            
            let name: String
            let text: String?
            
            lazy var asHTML: (Void) -> String = {
//                if let text = self.text {
//                    return "<\(self.name)>\(text)</\(self.name)>"
//                } else {
//                    return "<\(self.name) />"
//                }
                return "none"
            }
            
            init(name: String, text: String? = nil) {
                self.name = name
                self.text = text
            }
            
            deinit {
                print("\(name) is being deinitialized")
            }
            
        }
        
        let heading = HTMLElement(name: "h1")
        let defaultText = "some default text"
        heading.asHTML = {
            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
        }
        print(heading.asHTML())
        // 打印 “<h1>some default text</h1>”
        
        //解决闭包引起的循环强引用
        //Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()（而不只是someProperty或someMethod()）。这提醒你可能会一不小心就捕获了self。
        
        /*lazy var someClosure: (Int, String) -> String = {
         [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
         // 这里是闭包的函数体
         }
         
         lazy var someClosure: Void -> String = {
         [unowned self, weak delegate = self.delegate!] in
         // 这里是闭包的函数体
         }
         
         */
        var paragraph: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
        print(paragraph!.asHTML())
        // 打印 “<p>hello, world</p>”
        //这一次，闭包以无主引用的形式捕获self，并不会持有HTMLElement实例的强引用。如果将paragraph赋值为nil，HTMLElement实例将会被销毁，并能看到它的析构函数打印出的消息：
        paragraph = nil
        // 打印 “p is being deinitialized”
        
        
        
        
        
    }



}

class HTMLElement1 {
    
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
