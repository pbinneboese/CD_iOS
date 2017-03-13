//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var optionalString: String? = "Hello"
//print(optionalString == nil)

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

var aname: String? = "no"
print (aname)
aname = "hello"
print ("this  \(aname)")

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"

let type: String = "Rectangle"
let description: String = "A quadrilateral with four right angles"
var width: Double = 5
var height: Double = 10.5
var area: Double = width * height
height += 1
width += 1
area = width * height
// Note how you can "interpolate" variables into Strings using the following syntax
print("The shape is a \(type) or \(description) with an area of \(area)")
