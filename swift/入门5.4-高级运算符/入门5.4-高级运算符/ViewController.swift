//
//  ViewController.swift
//  入门5.4-高级运算符
//
//  Created by LiJie on 16/4/19.
//  Copyright © 2016年 LiJie. All rights reserved.
//

import UIKit

//==============================运算符重载。
//类和结构体可以为现有的运算符提供自定义的实现
struct Vector2D {
    var x = 0.0, y = 0.0
}
func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

//要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix(之前) 或者 postfix（之后） 修饰符：
prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

//inout 类型，因为这个参数的值会在运算符函数内直接被修改
func += ( left: inout Vector2D, right: Vector2D) {
    left = left + right
}

prefix func ++ ( vector: inout Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}
func != (left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}


//除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考运算符。
//新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
prefix operator +++ {}
prefix func +++ ( vector: inout Vector2D) -> Vector2D {
    vector += vector
    return vector
}


//自定义的中缀运算符也可以指定优先级和结合性。
//结合性可取的值有left，right 和 none。
//结合性的默认值是 none，优先级的默认值 100。

//以下例子定义了一个新的中缀运算符 +-，此运算符的结合性为 left，并且它的优先级为 140：
infix operator +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}




//======================================================
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。所有的这些溢出运算符都是以 & 开头的。
        
        
        
        //按位取反运算符（~）可以对一个数值的全部比特位进行取反：
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits // 等于 0b11110000
        
        
        //按位与运算符（&）可以对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1：
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8  = 0b00111111
        let middleFourBits = firstSixBits & lastSixBits // 等于 00111100
        
        
        //按位或运算符（|）可以对两个数的比特位进行比较。它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1：
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits // 等于 11111110
        
        
        //按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1：
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits // 等于 00010001
        
        
        //按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移
        /*
         1.已经存在的位按指定的位数进行左移和右移。
         2.任何因移动而超出整型存储范围的位都会被丢弃。
         3.用 0 来填充移位后产生的空白位。*/
        
        
        //==============有符号整数的移位运算
        //对比无符号整数，有符号整数的移位运算相对复杂得多，这种复杂性源于有符号整数的二进制表现形式。
        //有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。
        //即，Int8 有八位，第一位是符号位，0 000 0000
        //负数的表示通常被称为二进制补码表示。 1 111 1100 = -4    111 1100=124    (128-4)
        //当对正整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
        
        
        var potentialOverflow = Int16.max
        // potentialOverflow 的值是 32767，这是 Int16 能容纳的最大整数
//        potentialOverflow += 1
        // 这里会报错
        
        
        
        /*然而，也可以选择让系统在数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
         
         溢出加法 &+
         溢出减法 &-
         溢出乘法 &**/
        
        var unsignedOverflow = UInt8.max
        // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
        unsignedOverflow = unsignedOverflow &+ 1
        // 此时 unsignedOverflow 等于 0
        
        var unsignedOverflow1 = UInt8.min
        // unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
        unsignedOverflow1 = unsignedOverflow1 &- 1
        // 此时 unsignedOverflow1 等于 255
        
        
        
        //溢出也会发生在有符号整型数值上。在对有符号整型数值进行溢出加法或溢出减法运算时，符号位也需要参与计算
        var signedOverflow = Int8.min
        // signedOverflow 等于 Int8 所能容纳的最小整数 -128
        signedOverflow = signedOverflow &- 1
        // 此时 signedOverflow 等于 127
        
        
        //==============================运算符重载。
        //不能对默认的赋值运算符（=）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三目条件运算符 （a ? b : c） 进行重载。
        let vector = Vector2D(x: 3.0, y: 1.0)
        let anotherVector = Vector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVector
        // combinedVector 是一个新的 Vector2D 实例，值为 (5.0, 5.0)
        
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
        let alsoPositive = -negative
        // alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例
        
        
        var toIncrement = Vector2D(x: 3.0, y: 4.0)
        let afterIncrement = ++toIncrement
        // toIncrement 的值现在为 (4.0, 5.0)
        // afterIncrement 的值同样为 (4.0, 5.0)
        
        
        //自定义的中缀运算符也可以指定优先级和结合性。
        let firstVector = Vector2D(x: 1.0, y: 2.0)
        let secondVector = Vector2D(x: 3.0, y: 4.0)
        let plusMinusVector = firstVector +- secondVector
        // plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)
    }


}

