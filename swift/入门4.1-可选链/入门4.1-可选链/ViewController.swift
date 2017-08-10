//
//  ViewController.swift
//  入门4.1-可选链
//
//  Created by LiJie on 16/4/15.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        class Person {
            var residence: Residence?
        }
        
        class Residence0 {
            var numberOfRooms = 1
        }
        let john1 = Person()
//        let roomCount = john.residence!.numberOfRooms
        // 这会引发运行时错误
        
        
        //可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）：
        if let roomCount = john1.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “Unable to retrieve the number of rooms.”
        
        class Room {
            let name: String
            init(name: String) { self.name = name }
        }
        
        class Residence {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if buildingName != nil {
                    return buildingName
                } else if buildingNumber != nil && street != nil {
                    return "\(buildingNumber) \(street)"
                } else {
                    return nil
                }
            }
        }
        
        //通过可选链式调用访问属性
        //通过可选链式调用在一个可选值上访问它的属性，并判断访问是否成功。
        //下面的代码创建了一个Person实例，然后像之前一样，尝试访问numberOfRooms属性：
        let john = Person()
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “Unable to retrieve the number of rooms.”
        /*因为john.residence为nil，所以这个可选链式调用依旧会像先前一样失败。
         还可以通过可选链式调用来设置属性值：*/
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        john.residence?.address = someAddress
        //在这个例子中，通过john.residence来设定address属性也会失败，因为john.residence当前为nil。
        //上面代码中的赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行。对于上面的代码来说，很难验证这一点，因为像这样赋值一个常量没有任何副作用。下面的代码完成了同样的事情，但是它使用一个函数来创建Address实例，然后将该实例返回用于赋值。该函数会在返回前打印“Function was called”，这使你能验证等号右侧的代码是否被执行。
        
        func createAddress() -> Address {
            print("Function was called.")
            
            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            
            return someAddress
        }
        
        john.residence?.address = createAddress()
        //没有任何打印消息，可以看出createAddress()函数并未被执行。
        
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // 打印 “It was not possible to print the number of rooms.”
        
        if (john.residence?.address = someAddress) != nil {
            print("It was possible to set the address.")
        } else {
            print("It was not possible to set the address.")
        }
        // 打印 “It was not possible to set the address.”
        
        
        
        //===================通过可选链式调用访问下标
        //通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功。
        //通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // 打印 “Unable to retrieve the first room name.”
        
        john.residence?[0] = Room(name: "Bathroom")
        //这次赋值同样会失败，因为residence目前是nil。
        
        
        let johnsHouse = Residence()
        johnsHouse.rooms.append(Room(name: "Living Room"))
        johnsHouse.rooms.append(Room(name: "Kitchen"))
        john.residence = johnsHouse
        
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // 打印 “The first room name is Living Room.”
        
        
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0]+=1
        testScores["Brian"]?[0] = 72
        // "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
        //上面的例子中定义了一个testScores数组，包含了两个键值对，把String类型的键映射到一个Int值的数组。这个例子用可选链式调用把"Dave"数组中第一个元素设为91，把"Bev"数组的第一个元素+1，然后尝试把"Brian"数组中的第一个元素设为72。前两个调用成功，因为testScores字典中包含"Dave"和"Bev"这两个键。但是testScores字典中没有"Brian"这个键，所以第三个调用失败。
        
        
        //============连接多层可选链式调用
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // 打印 “Unable to retrieve the address.”
        
        let johnsAddress = Address()
        johnsAddress.buildingName = "The Larches"
        johnsAddress.street = "Laurel Street"
        john.residence?.address = johnsAddress
        
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // 打印 “John's street name is Laurel Street.”
        
        //在方法的可选返回值上进行可选链式调用
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
            print("John's building identifier is \(buildingIdentifier).")
        }
        // 打印 “John's building identifier is The Larches.”
        
        
        //如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可：
        if let beginsWithThe =
            john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            if beginsWithThe {
                print("John's building identifier begins with \"The\".")
            } else {
                print("John's building identifier does not begin with \"The\".")
            }
        }
        // 打印 “John's building identifier begins with "The".”
    }
}

