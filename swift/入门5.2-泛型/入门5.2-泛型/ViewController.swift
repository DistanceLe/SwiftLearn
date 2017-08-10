//
//  ViewController.swift
//  入门5.2-泛型
//
//  Created by LiJie on 16/4/19.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

//==========================关联类型  associatedType
//定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。
//关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。
//你可以通过 associatedtype 关键字来指定关联类型。
//该协议定义了一个关联类型 ItemType：
protocol Container{
    
    associatedtype ItemType
    
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType {get}
    
}

struct Stack<Element>: Container {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    
    // Container 协议的实现部分
    mutating func append(_ item: Element) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//==================扩展一个泛型类型
//下面的例子扩展了泛型类型 Stack，为其添加了一个名为 topItem 的只读计算型属性，它将会返回当前栈顶端的元素而不会将其从栈中移除：
extension Stack{
    var topItem: Element?{
        return items.isEmpty ? nil : items[items.count-1]
    }
    
}


//任何遵从 Container 协议的类型必须能够指定其存储的元素的类型，必须保证只有正确类型的元素可以加进容器中，必须明确通过其下标返回的元素的类型。
struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    
//    typealias ItemType = Int  //这一行 可写可不写。能被推断出来
    mutating func append(_ item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

//通过扩展一个存在的类型来指定关联类型
extension Array: Container{}  //Array 已经实现四协议的所有内容，


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //泛型代码让你能够根据自定义的需求，编写出适用于任意类型、灵活可重用的函数及类型。它能让你避免代码的重复，用一种清晰和抽象的方式来表达代码的意图。
        //泛型是 Swift 最强大的特性之一，许多 Swift 标准库是通过泛型代码构建的
        func swapTwoInts( a: inout Int, _ b: inout Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        func swapTwoDoubles( a: inout Double, _ b: inout Double) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        //============泛型函数
        func swapTwoValues<T>( a: inout T, _ b: inout T){
            let tempA = a
            a = b
            b = tempA
        }
        //这个函数的泛型版本使用了占位类型名（在这里用字母 T 来表示）来代替实际类型名（例如 Int、String 或 Double）。占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。
        //占位类型名（T），用尖括号括起来（<T>）。这个尖括号告诉 Swift 那个 T 是 swapTwoValues(_:_:) 函数定义内的一个占位类型名，因此 Swift 不会去查找名为 T 的实际类型。
        //你可提供多个类型参数，将它们都写在尖括号中，用逗号分开。
        
        var someInt = 3
        var anotherInt = 107
        swapTwoValues(a: &someInt, &anotherInt)
//        swapTwoValues(&someInt, &anotherInt)
        
        swap(&someInt, &anotherInt)
        
        //在大多数情况下，类型参数具有一个描述性名字，例如 Dictionary<Key, Value> 中的 Key 和 Value，以及 Array<Element> 中的 Element，这可以告诉阅读代码的人这些类型参数和泛型函数之间的关系。然而，当它们之间没有有意义的关系时，通常使用单个字母来命名，例如 T、U、V
        //请始终使用大写字母开头的驼峰命名法（例如 T 和 MyTypeParameter）来为类型参数命名，以表明它们是占位类型，而不是一个值。
        //非泛型栈
        struct IntStack {
            var items = [Int]()
            mutating func push(item: Int) {
                items.append(item)
            }
            mutating func pop() -> Int {
                return items.removeLast()
            }
        }
        
        var stackOfSting = Stack<String>()
        stackOfSting.push(item: "uno")
        stackOfSting.push(item: "dos")
        stackOfSting.push(item: "tres")
        stackOfSting.pop()
        
        if let topItem = stackOfSting.topItem {
            print("The top item on the stack is \(topItem).")
        }
        
        
        //======================类型约束
        //func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
        // 这里是泛型函数的函数体部分
        //}
        func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        // Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符(!=)，从而能对该类型的任意两个值进行比较
        func findIndex<T :Equatable>(array: [T], _ valueToFind: T) -> Int? {
            for (index, value) in array.enumerated() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        
        
        //=========================Where 子句
        //你能通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。
        //泛型 Where 语句写在一个类型或函数体的左半个大括号前面
        func allItemsMatch<
            C1: Container, C2: Container>
            (someContainer: C1, _ anotherContainer: C2) -> Bool
            where C1.ItemType == C2.ItemType, C1.ItemType: Equatable{
            
            // 检查两个容器含有相同数量的元素
            if someContainer.count != anotherContainer.count {
                return false
            }
            
            // 检查每一对元素是否相等
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }
            
            // 所有元素都匹配，返回 true
            return true
        }
        
        
        //=====
        var stackOfStrings = Stack<String>()
        stackOfStrings.push(item: "uno")
        stackOfStrings.push(item: "dos")
        stackOfStrings.push(item: "tres")
        
        let arrayOfStrings = ["uno", "dos", "tres"]
        
        if allItemsMatch(someContainer: stackOfStrings, arrayOfStrings) {
            print("All items match.")
        } else {
            print("Not all items match.")
        }
        // 打印 “All items match.”
        
        
    }

}

