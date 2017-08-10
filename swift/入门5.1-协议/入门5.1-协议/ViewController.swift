//
//  ViewController.swift
//  入门5.1-协议
//
//  Created by LiJie on 16/4/18.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit


//协议定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体或枚举都可以采纳协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说该类型“符合”这个协议。
//除了采纳协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样采纳协议的类型就能够使用这些功能。
protocol someProtocol1{
    // 这里是协议的定义部分
}

//自定义类型采纳某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。采纳多个协议时，各协议之间用逗号（,）分隔：
//struct SomeStructure: someProtocol1, AnotherProtocol {
    // 这里是结构体的定义部分
//}

//拥有父类的类在采纳协议时，应该将父类名放在协议名之前，以逗号分隔：
//class SomeClass: SomeSuperClass, someProtocol1, AnotherProtocol {
    // 这里是类的定义部分
//}





//=======================属性：
//协议可以要求采纳协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
//协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示：

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型采纳协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}


//==========================方法：
//协议可以要求采纳协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
//在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型采纳协议时，除了 static 关键字，还可以使用 class 关键字作为前缀：
protocol StaticFuncProtocol{
    static func someTypeMethod()
}

protocol FuncProtocol {
    func random()->Double
}



//=========================Mutaing 方法要求
//有时需要在方法中改变方法所属的实例,在值类型（即结构体和枚举）的实例方法中，将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值
//如果你在协议中定义了一个实例方法，该方法会改变采纳该协议的类型的实例，那么在定义协议时需要在方法前加 mutating 关键字。
//实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字。
protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On  //修改了所属实例 或所属实例的属性
        case .On:
            self = .Off
        }
    }
}



//========================构造器要求
//协议可以要求采纳协议的类型实现指定的构造器。你可以像编写普通构造器那样，在协议的定义里写下构造器的声明，但不需要写花括号和构造器的实体：
protocol InitProtocol{
    init(someParamer: Int)
}

//你可以在采纳协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
//使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能符合协议。
//如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符，因为 final 类不能有子类。
class InitClass: InitProtocol{
    required init(someParamer: Int){
        //...
    }
}

class SubInitClass: InitClass {
    //1.加上request
    required init(someParamer: Int) {
        super.init(someParamer: someParamer)
        //...
    }
}

//==========================协议作为类型
//尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用
/*
 作为函数、方法或构造器中的参数类型或返回值类型
 作为常量、变量或属性的类型
 作为数组、字典或其他容器中的元素类型*/

class TypeClass {
    let initProperty : InitProtocol
    
    init(initProperty: InitProtocol){
        self.initProperty = initProperty
    }
}
//initProperty 属性的类型为 InitProtocol，因此任何采纳了 InitProtocol 协议的类型的实例都可以赋值给 initProperty，除此之外并无其他要求。


//===========================委托（代理）模式
protocol RandomNumberGenerator {
    func random() -> Double
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) .truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int](repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(game: self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(game: self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(game: self)
    }
}
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


//==========================通过扩展添加协议
protocol TextRepresentable{
    var textualDescription: String{ get }
    
}

extension Dice: TextRepresentable{
    var textualDescription: String{
        return "A\(sides)-sided dice"
    }
}

//当一个类型已经符合了某个协议中的所有要求，却还没有声明采纳该协议时，可以通过空扩展体的扩展来采纳该协议：
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
//从现在起，Hamster 的实例可以作为 TextRepresentable 类型使用：
extension Hamster: TextRepresentable {}



//==========================协议继承
protocol PrettySubProtocol: TextRepresentable{
    var pretttyDescriptiong :String {get}
}

//==========================类类型专属协议
protocol SomeClassOnlyProtocol: class, SomeProtocol{
    
}

//===========================协议合成
//有时候需要同时采纳多个协议，你可以将多个协议采用 protocol<SomeProtocol, AnotherProtocol> 这样的格式进行组合，称为 协议合成（protocol composition）
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}


//===========================================可选的协议要求
@objc protocol CounterDataSource{
    @objc optional func incrementForCount(count: Int)-> Int
    @objc optional var fixedIncrement: Int {get}
}
//协议定义了一个可选方法 incrementForCount(_:) 和一个可选属性 fiexdIncrement，它们使用了不同的方法来从数据源中获取适当的增量值。
//如果你想要指定可选的协议要求，那么还是要为协议加上 @obj 特性。
//还需要注意的是，标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类采纳，其他类以及结构体和枚举均不能采纳这种协议。

//严格来讲，CounterDataSource 协议中的方法和属性都是可选的，因此采纳协议的类可以不实现这些要求，尽管技术上允许这样做，不过最好不要这样写。
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

//===============协议扩展
//协议可以通过扩展来为采纳协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个采纳协议的类型中都重复同样的实现，也无需使用全局函数
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
//可以通过协议扩展来为协议要求的属性、方法以及下标提供默认的实现。如果采纳协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用
//=============为协议扩展添加限制条件
//这些限制条件写在协议名之后，使用 where 子句来描述

//你可以扩展 CollectionType 协议，但是只适用于集合中的元素采纳了 TextRepresentable 协议的情况：
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
//如果多个协议扩展都为同一个协议要求提供了默认实现，而采纳协议的类型又同时满足这些协议扩展的限制条件，那么将会使用限制条件最多的那个协议扩展提供的默认实现。

//============================================
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //===============委托、代理
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        
        
        //===================
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        
        
        //=======================协议类型的集合
        let things: [TextRepresentable]
        
        //===========================协议合成
        //协议合成并不会生成新的、永久的协议类型，而是将多个协议中的要求合成到一个只在局部作用域有效的临时协议中。
        func wishHappyBirthday(celebrator: Named & Aged) {
            print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
        }
        let birthdayPerson = Person(name: "Malcolm", age: 21)
        wishHappyBirthday(celebrator: birthdayPerson)
        
        
        
        //=============================检查协议一致性
        /*
         is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
         as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
         as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
         */
        
        
        //===============协议扩展
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // 打印 “Here's a random number: 0.37464991998171”
        print("And here's a random Boolean: \(generator.randomBool())")
        // 打印 “And here's a random Boolean: true”
        
        //=========
        let murrayTheHamster = Hamster(name: "Murray")
        let morganTheHamster = Hamster(name: "Morgan")
        let mauriceTheHamster = Hamster(name: "Maurice")
        let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
        //因为 Array 符合 CollectionType 协议，而数组中的元素又符合 TextRepresentable 协议，所以数组可以使用 textualDescription 属性得到数组内容的文本表示：
//        print(hamsters.textualDescription)
        // 打印 “[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]”
        
    }




}

