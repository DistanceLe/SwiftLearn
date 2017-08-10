//
//  ViewController.swift
//  入门5.3-访问控制
//
//  Created by LiJie on 16/4/19.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

public class SomePublicClass {          // 显式的 public 类
    public var somePublicProperty = 0   // 显式的 public 类成员
    var someInternalProperty = 0        // 隐式的 internal 类成员
    private func somePrivateMethod() {} // 显式的 private 类成员
}

class SomeInternalClass {               // 隐式的 internal 类
    var someInternalProperty = 0        // 隐式的 internal 类成员
    private func somePrivateMethod() {} // 显式的 private 类成员
}

private class SomePrivateClass {        // 显式的 private 类
    var somePrivateProperty = 0         // 隐式的 private 类成员
    func somePrivateMethod() {}         // 隐式的 private 类成员
}


//枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
public enum CompassPoint {
    case North
    case South
    case East
    case West
}

//通过这种方式，我们就可以将某类中 private 级别的类成员重新指定为更高的访问级别，以便其他人使用：
public class A {
    private func someMethod() {}
}

internal class B: A {
    internal func someMethod() {}
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //访问控制可以限定其他源文件或模块中的代码对你的代码的访问级别。这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口
        
        //在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
        //在 Swift 中，Xcode 的每个 target（例如框架或应用程序）都被当作独立的模块处理。
        //如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时，框架内容都将属于这个独立的模块。
        //源文件就是 Swift 中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。
        
        
        
        /*public：可以访问同一模块源文件中的任何实体，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，框架中的某个接口可以被任何人使用时，你可以将其设置为 public 级别。
         internal：可以访问同一模块源文件中的任何实体，但是不能从模块外访问该模块源文件中的实体。通常情况下，某个接口只在应用程序或框架内部使用时，你可以将其设置为 internal 级别。
         private：限制实体只能在所在的源文件内部使用。使用 private 级别可以隐藏某些功能的实现细节。*/
        //Swift 中的 private 访问级别不同于其他语言，它的范围限于源文件，而不是声明范围内。这就意味着，一个类型可以访问其所在源文件中的所有 private 实体，但是如果它的扩展定义在其他源文件中，那么它的扩展就不能访问它在这个源文件中定义的 private 实体。
        
        
        
        //如果你不为代码中的实体显式指定访问级别，那么它们默认为 internal 级别
        //一个 public 类型的所有成员的访问级别默认为 internal 级别，而不是 public 级别。如果你想将某个成员指定为 public 级别，那么你必须显式指定。
        
        
        
        //元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal 级别，另一个类型为 private 级别，那么这个元组的访问级别为 private。
        //元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
        
        
        
        //也许你会认为该函数应该拥有默认的访问级别 internal，但事实并非如此。事实上，如果按下面这种写法，代码将无法通过编译
//        func someFunction() -> (SomeInternalClass, SomePrivateClass) {
            // 此处是函数实现部分
//        }
        
        
        //这个函数的返回类型是一个元组，该元组中包含两个自定义的类（可查阅自定义类型）。其中一个类的访问级别是 internal，另一个的访问级别是 private，所以根据元组访问级别的原则，该元组的访问级别是 private
//        private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
            // 此处是函数实现部分
//        }
        
        //如果在 private 级别的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
        
        //子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
        //此外，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。
        
        
        //常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。
        
        
        //如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可
        //协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意采纳者都将可用。
        
        
        
        //采纳了协议的类型的访问级别取它本身和所采纳协议两者间最低的访问级别。也就是说如果一个类型是 public 级别，采纳的协议是 internal 级别，那么采纳了这个协议后，该类型作为符合协议的类型时，其访问级别也是 internal。
        
        
        
        
        
        
        
    }
}

