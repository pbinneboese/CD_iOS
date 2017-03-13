//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var i:Int
for i in 1...255 {
    print(i)
}

for i in 1...100 {
    if ((i%3==0) && !(i%5==0)) || (!(i%3==0) && (i%5==0)) {
        print(i)
    }
}

for i in 1...100 {
    if (i%3==0) && (i%5==0) {
        print ("FizzBuzz \(i)")
    }
    else if (i%3==0) {
        print ("Fizz \(i)")
    }
    else if (i%5==0) {
        print ("Buzz \(i)")
    }
}
