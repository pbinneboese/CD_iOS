//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr1:[Int] = []
var arr1size:Int = 255

for i in 1...arr1size {
    arr1.append(i)
}
print(arr1)
// now swap 2 random values
var rand1 = Int(arc4random_uniform(UInt32(arr1size-1)))
var rand2 = Int(arc4random_uniform(UInt32(arr1size-1)))
var temp:Int
temp = arr1[rand1]
arr1[rand1] = arr1[rand2]
arr1[rand2] = temp
print("Swap indices \(rand1+1) with \(rand2+1)")
print(arr1)
// now shuffle 100 values
for i in 1...100 {
    rand1 = Int(arc4random_uniform(UInt32(arr1size-1)))
    rand2 = Int(arc4random_uniform(UInt32(arr1size-1)))
    temp = arr1[rand1]
    arr1[rand1] = arr1[rand2]
    arr1[rand2] = temp
    print("Swap indices \(rand1+1) with \(rand2+1)")
}
print(arr1)
// find the value "42" and remove it
var i = 0
while i < arr1size {
    if arr1[i] == 42 {
        print("We found the answer to the Ultimate Question of Life, the Universe and Everything at index \(i)")
        break
    }
    else {
        i += 1
    }
}
// shift remaining values over to fill in
while i < arr1size-1 {
    arr1[i] = arr1[i+1]
    i += 1
}
arr1[i] = 0
print(arr1)
