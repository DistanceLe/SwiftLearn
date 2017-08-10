//
//  ViewController.swift
//  入门2.4-属性和方法
//
//  Created by LiJie on 16/4/14.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
        //引用类型的类（class）则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
        
        
        //========延迟存储属性
        
        //延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性。
        //必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
        class DataImporter {
            /*
             DataImporter 是一个负责将外部文件中的数据导入的类。
             这个类的初始化会消耗不少时间。
             */
            var fileName = "data.txt"
            // 这里会提供数据导入功能
        }
        
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
            // 这里会提供数据管理功能
        }
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
        print(manager.importer.fileName)
        // DataImporter 实例的 importer 属性现在被创建了
        // 输出 "data.txt”
        
        
        //============计算属性
        //计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
        struct Point{
            var x = 0.0, y = 0.0
        }
        struct Size{
            var width = 0.0, height = 0.0
        }
        struct Rect{
            var origin = Point()
            var size = Size()
            var center: Point {
                get{
                    return Point(x: origin.x+(size.width/2), y: origin.y+(size.height/2))
                }
                set(newCenter){
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // 输出 "square.origin is now at (10.0, 10.0)”
        
        
        //========只读计算属性
        
        //只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值。
        //必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
        //只读计算属性的声明可以去掉 get 关键字和花括号：
        struct Cuboid{
            var width = 0.0, height = 0.0, depth = 0.0
            var volume : Double{
                return width * height * depth
            }
        }
        
        //========属性观察器
        /*willSet 在新的值被设置之前调用
         didSet 在新的值被设置之后立即调用*/
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) {
                    print("About to set totalSteps to \(newTotalSteps)")
                }
                didSet {
                    if totalSteps > oldValue  {
                        print("Added \(totalSteps - oldValue) steps")
                    }
                }
            }
        }
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
        //==========类型属性
        //无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属性
        //存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
        //使用关键字 static 来定义类型属性。在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写。下面的例子演示了存储型和计算型类型属性的语法
        //必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过程中使用构造器给类型属性赋值。
        //存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27
            }
            class var overrideableComputedTypeProperty: Int {
                return 107
            }
        }
       
        //重写父类的实现
        class SonClass:SomeClass{
            
            override class var overrideableComputedTypeProperty: Int {
                return 222
            }
        }
        
        //跟实例属性一样，类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例。比如：
        print(SomeStructure.storedTypeProperty)
        // 输出 "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 输出 "Another value.”
        print(SomeEnumeration.computedTypeProperty)
        // 输出 "6"
        print(SomeClass.computedTypeProperty)
        // 输出 "27"
        print(SomeClass.overrideableComputedTypeProperty)
        print(SonClass.overrideableComputedTypeProperty)
        
        //在第一个检查过程中，didSet 属性观察器将 currentLevel 设置成了不同的值，但这不会造成属性观察器被再次调用。
        struct AudioChannel {
            static let thresholdLevel = 10
            static var maxInputLevelForAllChannels = 0
            var currentLevel: Int = 0 {
                didSet {
                    if currentLevel > AudioChannel.thresholdLevel {
                        // 将当前音量限制在阀值之内
                        currentLevel = AudioChannel.thresholdLevel
                    }
                    if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                        // 存储当前音量作为新的最大输入音量
                        AudioChannel.maxInputLevelForAllChannels = currentLevel
                    }
                }
            }
        }
        
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)
        // 输出 "7"
        print(AudioChannel.maxInputLevelForAllChannels)
        // 输出 "7"
        
        AudioChannel.maxInputLevelForAllChannels=100
        print(rightChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
        
        
        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)
        // 输出 "10"
        print(AudioChannel.maxInputLevelForAllChannels)
        // 输出 "10"
        
        print(leftChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
        
        
        //===================================================================
        //===================================================================
        //方法：
        /*实例方法(Instance Methods)
         类型方法(Type Methods)*/
        //方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法；实例方法为给定类型的实例封装了具体的任务与功能。类、结构体、枚举也可以定义类型方法；类型方法与类型本身相关联。类型方法与 Objective-C 中的类方法（class methods）相似。
        //结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型（类/结构体/枚举）上定义方法。
        
        
        //在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)
        //要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了
        struct Point1 {
            var x = 0.0, y = 0.0
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint = Point1(x: 1.0, y: 1.0)
        somePoint.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印输出: "The point is now at (3.0, 4.0)"
        //注意，不能在结构体类型的常量（a constant of structure type）上调用可变方法，因为其属性不能被改变
//        let fixedPoint = Point1(x: 3.0, y: 3.0)
//        fixedPoint.moveByX(2.0, y: 3.0)
        // 这里将会报告一个错误
        
        //在可变方法中给 self 赋值
        struct Point2 {
            var x = 0.0, y = 0.0
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                self = Point2(x: x + deltaX, y: y + deltaY)
            }
        }
        
        //枚举的可变方法可以把self设置为同一枚举类型中不同的成员：
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case .Off:
                    self = .Low
                case .Low:
                    self = .High
                case .High:
                    self = .Off
                }
            }
        }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        // ovenLight 现在等于 .High
        ovenLight.next()
        // ovenLight 现在等于 .Off
        
        
        //=============类型方法
        //在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
        class SomeClass1 {
            static func someTypeMethod() {
                // type method implementation goes here
            }
        }
        SomeClass1.someTypeMethod()
        
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            static func unlockLevel(level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }
            static func levelIsUnlocked(level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
            var currentLevel = 1
            mutating func advanceToLevel(level: Int) -> Bool {
                if LevelTracker.levelIsUnlocked(level: level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            func completedLevel(level: Int) {
                LevelTracker.unlockLevel(level: level + 1)
                tracker.advanceToLevel(level: level + 1)
            }
            init(name: String) {
                playerName = name
            }
        }
        
        var player = Player(name: "Argyrios")
        player.completedLevel(level: 1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // 打印输出：highest unlocked level is now 2
        
        
        player = Player(name: "Beto")
        if player.tracker.advanceToLevel(level: 6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // 打印输出：level 6 has not yet been unlocked
        
        
        
        
        //====================================================
        //====================================================
        //小标
        //下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于实例方法语法和计算型属性语法的混合。与定义实例方法类似，定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
        class SubClass{
            subscript(index: Int)->Int{
                get{
                    return 10
                }
                set{
                    
                }
            }
        }
        
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // 输出 "six times three is 18"
        
        
        //下标用法
        //下标的确切含义取决于使用场景。下标通常作为访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式。你可以针对自己特定的类或结构体的功能来自由地以最恰当的方式实现下标。
        var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberOfLegs["bird"] = 2
        
        
        //下标选项
        //下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
        //一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。
        //虽然接受单一入参的下标是最常见的，但也可以根据情况定义接受多个入参的下标。例如下例定义了一个Matrix结构体，用于表示一个Double类型的二维矩阵。Matrix结构体的下标接受两个整型参数：
        struct Item {
            var price=0
            var count=0
        }
        struct Matrix {
            var inventory = [
                "Candy Bar": Item(price: 8, count:4),
                "Chips": Item(price: 10, count: 4),
                "Pretzels": Item(price: 7, count: 11)
            ]

            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(repeating: 0.0, count: rows * columns)
            }
            func indexIsValidForRow(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValidForRow(row: row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
        }
        
        //下例中创建了一个Matrix实例来表示两行两列的矩阵。该Matrix实例的grid数组按照从左上到右下的阅读顺序将矩阵扁平化存储：
        var matrix = Matrix(rows: 2, columns: 2)
        //将row和column的值传入下标来为矩阵设值，下标的入参使用逗号分隔：
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        
        
//        let someValue = matrix[2, 2]
        // 断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
        
        
        
        
        
        
        
        
        
        
    }


}

