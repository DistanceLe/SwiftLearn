//
//  ViewController.swift
//  入门3.1-构造过程
//
//  Created by LiJie on 16/4/15.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //====================构造过程======================
        //构造过程是使用类、结构体或枚举类型的实例之前的准备过程。在新实例可用前必须执行这个过程，具体操作包括设置实例中每个存储型属性的初始值和执行其他必须的设置或初始化工作。
        //Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始化。
        
        //类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
        //你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。
        
        struct Fahrenheit{
            var temperature: Double
            
            init(){
                temperature = 32.0
            }
        }
        
        let f = Fahrenheit()
        print(f.temperature)
        
        struct Celsius{
            var temperatureInCelsius: Double
            init(fromFahrenheit fhrenheit:Double){
                temperatureInCelsius = (fhrenheit - 32.0)/1.8
            }
            init(fromkelvin kelvin:Double){
                temperatureInCelsius = kelvin - 273.15
            }
        }
        
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        let freezingPointOfWater = Celsius(fromkelvin: 273.15)
        
        //构造器并不像函数和方法那样在括号前有一个可辨别的名字。因此在调用构造器时，主要通过构造器中的参数名和类型来确定应该被调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为构造器的每个参数自动生成一个跟内部名字相同的外部名。
        struct Color {
            let red, green, blue: Double
            init(red: Double, green: Double, blue: Double) {
                self.red   = red
                self.green = green
                self.blue  = blue
            }
            init(_ white: Double) {
                red   = white
                green = white
                blue  = white
            }
        }
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 0.4)
        let halfGray = Color(0.5)
        
//        let veryGreen = Color(0.0, 1.0, 0.0)
        // 报编译时错误，需要外部名称
        //如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名
        
        
        //如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为可选类型（optional type）。可选类型的属性将自动初始化为nil，表示这个属性是有意在初始化时设置为空的。
        class SurveyQuestion {
            var text: String
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // 输出 "Do you like cheese?"
        cheeseQuestion.response = "Yes, I do like cheese."
        
        //对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。
        //你可以修改上面的SurveyQuestion示例，用常量属性替代变量属性text，表示问题内容text在SurveyQuestion的实例被创建之后不会再被修改。尽管text属性现在是常量，我们仍然可以在类的构造器中设置它的值：
        
        
        //============默认构造器
        //如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
        
        //如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
        struct Size{
            var width = 0.0, height = 0.0
            
        }
        struct Point {
            var x = 0.0, y = 0.0
        }
        
        let twoByTwo = Size(width: 2.0, height: 2.0)
        
        //对于值类型，你可以使用self.init在自定义的构造器中引用类型中的其它构造器。并且你只能在构造器内部调用self.init。
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        
        
        //=-===================指定构造器和便利构造器
        //每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。
        
        //便利构造器（convenience initializers）是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。
        //便利构造器需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
        
        //指定构造器必须调用其直接父类的的指定构造器。
        //便利构造器必须调用同一类中定义的其它构造器。
        //便利构造器必须最终导致一个指定构造器被调用。
        
        
        //==================两段式构造过程
        /*阶段 1
         
         某个指定构造器或便利构造器被调用。
         完成新实例内存的分配，但此时内存还没有被初始化。
         指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
         指定构造器将调用父类的构造器，完成父类属性的初始化。
         这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
         当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
         阶段 2
         
         从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
         最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。*/
        
        
        
        //===========构造器的继承和重写
        //你在编写一个和父类中指定构造器相匹配的子类构造器时，你实际上是在重写父类的这个指定构造器。因此，你必须在定义子类构造器时带上override修饰符。即使你重写的是系统自动提供的默认构造器，也需要带上override修饰符
        class Vehicle {
            var numberOfWheels = 0
            var description: String {
                return "\(numberOfWheels) wheel(s)"
            }
        }
        class Bicycle1: Vehicle {
            override init() {
                super.init()
                numberOfWheels = 2
            }
        }
        
        //子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性
        class Food {
            var name: String
            init(name: String) {
                self.name = name
            }
            convenience init() {
                self.init(name: "[Unnamed]")
            }
        }
        
        class RecipeIngredient: Food {
            var quantity: Int
            init(name: String, quantity: Int) {
                self.quantity = quantity
                super.init(name: name)
            }
            override convenience init(name: String) {
                self.init(name: name, quantity: 1)
            }
        }
        
        let recipe = RecipeIngredient()
        print(recipe.quantity, "-------", recipe.name)
        //1 ------- [Unnamed]
        
        
        
        
        //=================可失败构造器
        //为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
        //可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
        //可失败构造器会创建一个类型为自身类型的可选类型的对象。你通过return nil语句来表明可失败构造器在何种情况下应该“失败”。
        //严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。
        struct Animal {
            let species: String
            
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = species
            }
        }
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature 的类型是 Animal? 而不是 Animal
        
        let anonymousCreature = Animal(species: "")
        // anonymousCreature 的类型是 Animal?, 而不是 Animal

        
        //枚举类型的可失败构造器
        //你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。
        enum TemperatureUnit1 {
            case Kelvin, Celsius, Fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .Kelvin
                case "C":
                    self = .Celsius
                case "F":
                    self = .Fahrenheit
                default:
                    return nil
                }
            }
        }
        
        //带原始值的枚举类型的可失败构造器
        //带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)，该可失败构造器有一个名为rawValue的参数，其类型和枚举类型的原始值类型一致，如果该参数的值能够和某个枚举成员的原始值匹配，则该构造器会构造相应的枚举成员，否则构造失败。
        
        enum TemperatureUnit: Character {
            case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
        }
        
        let fahrenheitUnit = TemperatureUnit(rawValue: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // 打印 "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(rawValue: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // 打印 "This is not a defined temperature unit, so initialization failed."
        
        
        
        //==================重写一个可失败构造器
        //如同其它的构造器，你可以在子类中重写父类的可失败构造器。或者你也可以用子类的非可失败构造器重写一个父类的可失败构造器。这使你可以定义一个不会构造失败的子类，即使父类的构造器允许构造失败。
        //当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
        //你可以用非可失败构造器重写可失败构造器，但反过来却不行。
        class Document {
            var name: String?
            // 该构造器创建了一个 name 属性的值为 nil 的 document 实例
            init() {}
            // 该构造器创建了一个 name 属性的值为非空字符串的 document 实例
            init?(name: String) {
                self.name = name
                if name.isEmpty { return nil }
            }
        }
        
        
        class AutomaticallyNamedDocument: Document {
            override init() {
                super.init()
                self.name = "[Untitled]"
            }
            override init(name: String) {
                super.init()
                if name.isEmpty {
                    self.name = "[Untitled]"
                } else {
                    self.name = name
                }
            }
        }
        
        //======================可失败构造器 init!
        //通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（(init!)），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
        
        //你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。
        
        
        //=====================必要构造器
        //在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
        class SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        
        //在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。在重写父类中必要的指定构造器时，不需要添加override修饰符：
        //如果子类继承的构造器能满足必要构造器的要求，则无须在子类中显式提供必要构造器的实现。
        class SomeSubclass: SomeClass {
            required init() {
                // 构造器的实现代码
            }
        }
        
        //=====================通过闭包或函数设置属性的默认值
        /*如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
         
         这种类型的闭包或函数通常会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后返回这个临时变量，作为属性的默认值。*/
        //如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。
        struct Checkerboard {
            
            let boardColors: [Bool] = {
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...10 {
                    for j in 1...10 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            //闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
            
            func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
                return boardColors[(row * 10) + column]
            }
        }
        
        let board = Checkerboard()
        print(board.squareIsBlackAtRow(row: 0, column: 1))
        // 打印 "true"
        print(board.squareIsBlackAtRow(row: 9, column: 9))
        // 打印 "false"
        
        
        
        //=============================析构过程
        //析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。
        /*Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过自动引用计数（ARC）处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。
         
         在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数
         
         析构器是在实例释放发生前被自动调用。你不能主动调用析构器。子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用。
         
         因为直到实例的析构器被调用后，实例才会被释放，所以析构器可以访问实例的所有属性，并且可以根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）。*/
        
        class Bank {
            static var coinsInBank = 10_000
            static func vendCoins( numberOfCoinsToVend: Int) -> Int {
                var numberOfCoinsToVend = numberOfCoinsToVend
                numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
                coinsInBank -= numberOfCoinsToVend
                return numberOfCoinsToVend
            }
            static func receiveCoins(coins: Int) {
                coinsInBank += coins
            }
        }
        class Player {
            var coinsInPurse: Int
            init(coins: Int) {
                coinsInPurse = Bank.vendCoins(numberOfCoinsToVend: coins)
            }
            func winCoins(coins: Int) {
                coinsInPurse += Bank.vendCoins(numberOfCoinsToVend: coins)
            }
            deinit {
                Bank.receiveCoins(coins: coinsInPurse)
            }
        }
        
        var playerOne: Player? = Player(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
        // 打印 "A new player has joined the game with 100 coins"
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        // 打印 "There are now 9900 coins left in the bank"
        
        
        //因为playerOne是可选的，所以访问其coinsInPurse属性来打印钱包中的硬币数量时，使用感叹号（!）来解包：
        playerOne!.winCoins(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
        // 输出 "PlayerOne won 2000 coins & now has 2100 coins"
        print("The bank now only has \(Bank.coinsInBank) coins left")
        // 输出 "The bank now only has 7900 coins left"
        
        //这里，玩家已经赢得了 2,000 枚硬币，所以玩家的钱包中现在有 2,100 枚硬币，而Bank对象只剩余 7,900 枚硬币。
        playerOne = nil
        print("PlayerOne has left the game")
        // 打印 "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins")
        // 打印 "The bank now has 10000 coins"
        
        //玩家现在已经离开了游戏。这通过将可选类型的playerOne变量设置为nil来表示，意味着“没有Player实例”。当这一切发生时，playerOne变量对Player实例的引用被破坏了。没有其它属性或者变量引用Player实例，因此该实例会被释放，以便回收内存。在这之前，该实例的析构器被自动调用，玩家的硬币被返还给银行。
    }
    

}

