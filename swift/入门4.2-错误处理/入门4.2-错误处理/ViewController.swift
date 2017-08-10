//
//  ViewController.swift
//  入门4.2-错误处理
//
//  Created by LiJie on 16/4/18.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /*表示并抛出错误
         处理错误
         指定清理操作*/
        
        //在 Swift 中，错误用符合ErrorType协议的类型的值来表示。这个空协议表明该类型可以用于错误处理。
        enum VendingMachineError: Error{
            case InvalidSelection;
            case InsufficientFunds(coinsNeeded: Int)
            case OutOfStock
        }
        
        //抛出异常，贩卖机还需要五个硬币
//        throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)
        
        //错误处理：
        //Swift 中有4种处理错误的方式。你可以把函数抛出的错误传递给调用此函数的代码、用do-catch语句处理错误、将错误作为可选类型处理、或者断言此错误根本不会发生。
        //Swift 中的错误处理和其他语言中用try，catch和throw进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的。
        
        //用 throwing 函数传递错误
        
        //为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。一个标有throws关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。
//        func cannotThrowError()-> String{
//            return "";
//        }
//        
//        func canThrowError() throws -> String{
//            return "";
//        }
        
        //======
        struct Item {
            var price: Int
            var count: Int
        }
//        class Temp{
//            let name = "abc"
//        }
//        var tempDic = ["bar": Temp()]
        
        
//        var barItem = Item(price: 12, count: 7)
//        var chipsItem = Item(price: 10, count: 4)
//        var pretzelsItem = Item(price: 7, count: 11)
//        
//        print("item.price=", barItem.price);
//        
//        var inventory = [
//            "Candy Bar": barItem,
//            "Chips": chipsItem,
//            "Pretzels": pretzelsItem
//        ]
        
        class VendingMachine {
            var inventory = [
                "Candy Bar": Item(price: 12, count: 7),
                "Chips": Item(price: 10, count: 4),
                "Pretzels": Item(price: 7, count: 11)
            ]
            var coinsDeposited = 0
            
            func dispenseSnack(snack: String) {
                print("Dispensing \(snack)")
            }
            
            func vend(itemNamed name: String) throws {
                guard var item = inventory[name] else {
                    throw VendingMachineError.InvalidSelection
                }
                
                guard item.count > 0 else {
                    throw VendingMachineError.OutOfStock
                }
                
                guard item.price <= coinsDeposited else {
                    throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
                }
                
                coinsDeposited -= item.price
                item.count -= 1
                inventory[name] = item
                dispenseSnack(snack: name)
            }
        }
        
        //=================
        let favoriteSnacks = [
            "Alice": "Chips",
            "Bob": "Licorice",
            "Eve": "Pretzels",
            ]
        func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
            let snackName = favoriteSnacks[person] ?? "Candy Bar"
            
            //因为vend(itemNamed:)方法能抛出错误，所以在调用的它时候在它前面加了try关键字。
            try vendingMachine.vend(itemNamed: snackName)
        }
        
        
        
        //用 Do-Catch 处理错误
        //可以使用一个do-catch语句运行一段闭包代码来处理错误。如果在do子句中的代码抛出了一个错误，这个错误会与catch子句做匹配，从而决定哪条子句能处理它。
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 2
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        } catch VendingMachineError.InvalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.OutOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        }catch{
            print("other exception")
        }
        // 打印 “Insufficient funds. Please insert an additional 2 coins.”
        
        
        //将错误转换成可选值
        //可以使用try?通过将错误转换成一个可选值来处理错误。如果在评估try?表达式时一个错误被抛出，那么表达式的值就是nil。
        
        //禁用错误传递
        //有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个断言不会有错误抛出的运行时断言中。如果实际上抛出了错误，你会得到一个运行时错误。
        
        
        
        //指定清理操作
        //可以使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如return或者break的语句。例如，你可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
        
        //defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如break或是return语句，或是抛出一个错误。延迟执行的操作会按照它们被指定时的顺序的相反顺序执行——也就是说，第一条defer语句中的代码会在第二条defer语句中的代码被执行之后才执行，以此类推。
//        func processFile(filename: String) throws {
//            if exists(filename) {
//                let file = open(filename)
//                defer {
//                    close(file)
//                }
//                while let line = try file.readline() {
//                    // 处理文件。
//                }
//                // close(file) 会在这里被调用，即作用域的最后。
//            }
//        }
        
    }


}

