//
//  ViewController.swift
//  入门4.3-类型转换
//
//  Created by LiJie on 16/4/18.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
        //类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
        
        class MediaItem {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        
        class Movie: MediaItem {
            var director: String
            init(name: String, director: String) {
                self.director = director
                super.init(name: name)
            }
        }
        
        class Song: MediaItem {
            var artist: String
            init(name: String, artist: String) {
                self.artist = artist
                super.init(name: name)
            }
        }
        
        var tempLibrary = [Any]()
        tempLibrary.append(Movie(name: "Casablanca", director: "Michael Curtiz"))
        
        
        
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        // 数组 library 的类型被推断为 [MediaItem]
        
        
        //检查类型（Checking Type）
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // 打印 “Media library contains 2 movies and 3 songs”
        
        
        //向下转型（Downcasting）
        //某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。
        //因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式（conditional form）as? 返回一个你试图向下转成的类型的可选值（optional value）。强制形式 as! 把试图向下转型和强制解包（force-unwraps）转换结果结合为一个操作。
        for item in library {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
        
        /*Any 和 AnyObject 的类型转换
         Swift 为不确定类型提供了两种特殊的类型别名：
         
         AnyObject 可以表示任何类类型的实例。
         Any 可以表示任何类型，包括函数类型。*/
        
        let someObjects: [AnyObject] = [
            Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
            Movie(name: "Moon", director: "Duncan Jones"),
            Movie(name: "Alien", director: "Ridley Scott")
        ]
        //因为知道这个数组只包含 Movie 实例，你可以直接用（as!）下转并解包到非可选的 Movie 类型：
        for object in someObjects {
            let movie = object as! Movie
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        }
        //为了变为一个更简短的形式，下转 someObjects 数组为 [Movie] 类型而不是下转数组中的每一项：
        for movie in someObjects as! [Movie] {
            print("Movie: '\(movie.name)', dir. \(movie.director)")
        }
        
        
        
        //Any 类型
        var things = [Any]()
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }
        
        
        //=======================嵌套
        //要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的{}内，而且可以根据需要定义多级嵌套
        struct BlackjackCard {
            // 嵌套的 Suit 枚举
            enum Suit: Character {
                case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
            }
            
            // 嵌套的 Rank 枚举
            enum Rank: Int {
                case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
                case Jack, Queen, King, Ace
                struct Values {
                    let first: Int, second: Int?
                }
                var values: Values {
                    switch self {
                    case .Ace:
                        return Values(first: 1, second: 11)
                    case .Jack, .Queen, .King:
                        return Values(first: 10, second: nil)
                    default:
                        return Values(first: self.rawValue, second: nil)
                    }
                }
            }
            
            // BlackjackCard 的属性和方法
            let rank: Rank, suit: Suit
            var description: String {
                var output = "suit is \(suit.rawValue),"
                output += " value is \(rank.values.first)"
                if let second = rank.values.second {
                    output += " or \(second)"
                }
                return output
            }
        }
        
        
        //引用嵌套类型
        //在外部引用嵌套类型时，在嵌套类型的类型名前加上其外部类型的类型名作为前缀：
        let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue
        // 红心符号为 “♡”
        
    }




}

