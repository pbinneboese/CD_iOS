//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Animal {
    var name:String
    var health:Int = 100
    
    init(_ name:String) {
        self.name = name
    }
    
    func displayHealth() ->Int {
        return self.health
    }
}

class Cat:Animal {
    init() {
        super.init("Cat")
        self.health = 150
    }
    func growl() {
        print("Rawr!")
    }
    func run() {
        if self.health >= 10 {
            print("Running")
            self.health -= 10
        }
    }
}

class Lion:Cat {

    override init() {
        super.init()
        self.health = 200
    }
    override func growl() {
        print("ROAR!!!!! I am the King of the Jungle")
    }
}

class Cheetah:Cat {
 
    override func run() {
        print("Running Fast")
        self.health -= 50
    }
    func sleep() {
        self.health += 50
        if self.health > 200 {
            self.health = 200
        }
    }
}

var myCheetah = Cheetah()
myCheetah.run()
myCheetah.run()
myCheetah.run()
myCheetah.run()
print("Cheetah's health is \(myCheetah.displayHealth())")
print("\n")

var myLion = Lion()
myLion.run()
myLion.run()
myLion.run()
print("Lion's health is \(myLion.displayHealth())")
myLion.growl()

