//
//  ViewController.swift
//  入门1.2
//
//  Created by LiJie on 16/4/11.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //集合：
        /*  Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集*/
        
        var someInt = [Int]() //创建一个由特定数据类型构成的空数组
        someInt.append(3)  // someInts 现在包含一个 Int 值
        someInt += [4]
        someInt=[]  // someInts 现在是空数组，但是仍然是 [Int] 类型的。
        
        let threeDoubles = [Double](repeating: 0.0, count: 3)
        
        let anotherDouble = threeDoubles + threeDoubles
        print(anotherDouble)
        
        
        //如果我们同时需要每个数据项的值和索引值，可以使用enumerate()方法来进行数组遍历。enumerate()返回一个由每一个数据项索引值和数据值组成的元组。我们可以把这个元组分解成临时常量或者变量来进行遍历：
        for (index, value) in anotherDouble.enumerated() {
            print("intem \(String(index+1)): \(value))")
        }
        
        /* Sets  集合类型的哈希值
         
         一个类型为了存储在集合中，该类型必须是可哈希化的--也就是说，该类型必须提供一个方法来计算它的哈希值。一个哈希值是Int类型的，相等的对象哈希值必须相同，比如a==b,因此必须a.hashValue == b.hashValue。
         
         Swift 的所有基本类型(比如String,Int,Double和Bool)默认都是可哈希化的，可以作为集合的值的类型或者字典的键的类型。没有关联值的枚举成员值(在枚举有讲述)默认也是可哈希化的。
         
         注意：
         你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型，但你需要使你的自定义类型符合 Swift 标准库中的Hashable协议。符合Hashable协议的类型需要提供一个类型为Int的可读属性hashValue。由类型的hashValue属性返回的值不需要在同一程序的不同执行周期或者不同程序之间保持相同。
         
         因为Hashable协议符合Equatable协议，所以符合该协议的类型也必须提供一个"是否相等"运算符(==)的实现。这个Equatable协议要求任何符合==实现的实例间都是一种相等的关系。也就是说，对于a,b,c三个值来说，==的实现必须满足下面三种情况：
         
         a == a(自反性)
         a == b意味着b == a(对称性)
         a == b && b == c意味着a == c(传递性)*/
        
        
        //创建和构造一个空的集合
        var letters  = Set<Character>()
        print(letters.count)
        
        letters.insert("a")//现在包含一个 character的值了
        letters = []    //现在是空的set，但是它依然是 Set<Character> 类型
        
        
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
        //等价：var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
        
        //你可以通过调用Set的remove(_:)方法去删除一个元素，如果该值是该Set的一个元素则删除该元素并且返回被删除的元素值，否则如果该Set不包含该值，则返回nil。另外，Set中的所有元素可以通过它的removeAll()方法删除。
        let removeItem = favoriteGenres.remove("Rock")
        print(removeItem)
        favoriteGenres.insert("love")
        favoriteGenres.insert("monday")
        favoriteGenres.insert("above")
        //Swift 的Set类型没有确定的顺序，为了按照特定顺序来遍历一个Set中的值可以使用sort()方法，它将根据提供的序列返回一个有序集合.
        for item in favoriteGenres.sorted() {
            print(item)
        }
        
        
        
        //基本集合操作
        /*使用intersect(_:)方法根据两个集合中都包含的值创建的一个新的集合。
         使用exclusiveOr(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
         使用union(_:)方法根据两个集合的值创建一个新的集合。
         使用subtract(_:)方法根据不在该集合中的值创建一个新的集合。*/
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        oddDigits.union(evenDigits).sorted()
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        oddDigits.intersection(evenDigits).sorted()
        // []
        oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        // [1, 9]
        oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        // [1, 2, 9]
        
        
        /*使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
         使用isSubsetOf(_:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
         使用isSupersetOf(_:)方法来判断一个集合中包含另一个集合中所有的值。
         使用isStrictSubsetOf(_:)或者isStrictSupersetOf(_:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
         使用isDisjointWith(_:)方法来判断两个集合是否不含有相同的值(是否没有交集)。*/
        
        
        //字典：
        //一个字典的Key类型必须遵循Hashable协议，就像Set的值类型
        //创建一个空字典
        var namesOfIntegers = [Int: String]()
        // namesOfIntegers 是一个空的 [Int: String] 字典
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers 现在包含一个键值对
        namesOfIntegers = [:]
        // namesOfIntegers 又成为了一个 [Int: String] 类型的空字典
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        //var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        
        //更新字典值
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        
        //遍历字典：
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
        
        //通过访问keys或者values属性，我们也可以遍历字典的键或者值：
        
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        
        for airportName in airports.values {
            print("Airport name: \(airportName)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

