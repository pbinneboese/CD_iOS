//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// print odds 1-255
print("Odds 1-255")
func printOdds() {
    for i in 1...255 {
        if (i%2==1) {
            print(i)
        }
    }
}
printOdds()

// count elements greater than Y
print("Count Elements Greater than Y")
func countGT(array:[Int], val:Int) -> Int {
    var count=0
    for i in 0..<array.count {
        if array[i] > val {
        count += 1
        }
    }
    return count
}
let arr1=[3,5,7,9,11]
let val1=6
var counter = countGT(array:arr1, val:val1)
print("array \(arr1) Y= \(val1) count \(counter)")

// swap string in for negative values
print("Swap String in for negative values")
func swapForNegs(theArray:[Int], theString:String) ->[Any] {
    var anyArray:[Any] = []
    for i in 0..<theArray.count {
        if theArray[i] >= 0 {
            anyArray.append(theArray[i])
        }
        else {
            anyArray.append(theString)
        }
    }
    return anyArray
}
let numArray:[Int] = [5,7,9,11,-3,4,-6]
var outArray:[Any] = []
outArray = swapForNegs(theArray:numArray, theString:"joker")
print ("in \(numArray)")
print ("out \(outArray)")

// insert at index arr, idx
print("insert at index")
func insertAtIndex(theArray: inout [Int], idx:Int, val:Int) {
    theArray[idx] = val
}
var Array2:[Int] = [5,3,4,2,8,6,0]
print("in \(Array2), index 4, val 45")
insertAtIndex(theArray:&Array2, idx:4, val:45)
print("out \(Array2)")

// Star art
print("Star art")
let lineLength = 75
var starLine:String = ""

func starArt(dir:String, num:Int) {
    var start = 0, end = 0
    if dir=="left" {
        start = 0
    }
    else if dir=="mid" {
        start = Int((lineLength-num)/2)
    }
    else if dir=="right" {
        start = lineLength - num
    }
    else {
        print("Direction Error")
    }
    end = start+num-1
//    starLine.append("S")
    for _ in 0..<start {
        starLine.append(" ")
    }
    for _ in start..<end {
            starLine.append("*")
        }
    for _ in end..<lineLength {
        starLine.append(" ")
    }
//    starLine.append("S")
}

print ("30 stars at left, middle, right")
starLine = ""
starArt(dir:"left", num:30)
print(starLine)
starLine = ""
starArt(dir:"mid", num:30)
print(starLine)
starLine = ""
starArt(dir:"right", num:30)
print(starLine)

// Recursive factorial
print("Recursive factorial")
func factorial(num:Int) -> Int {
    var newNum = num
    if newNum > 1 {
        newNum *= factorial(num:(newNum-1))
    }
    return newNum
}
print("factorial 5= \(factorial(num:5))")
print("factorial 8= \(factorial(num:8))")
print("factorial 18= \(factorial(num:18))")

