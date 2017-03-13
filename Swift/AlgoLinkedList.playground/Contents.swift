//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Node {
    var next:Node?
    var value:Int

    init(_ value:Int) {
        self.next = nil
        self.value = value
    }
}

class List {
    var head:Node?

    init() {
        self.head = nil
    }
    func traverse() {
        var runner:Node? = self.head
        while (runner != nil) {
            runner = runner?.next
        }
    }
    func addNode(_ value:Int) {   // adds node to end of list
        var runner:Node? = self.head
        if runner == nil {  // empty list
            self.head = Node(value)
            return
        }
        while (runner?.next != nil) {   // walk list to the end
            runner = runner?.next
        }
        runner?.next = Node(value)  // insert node
    }
    func removeNode() ->Int? {   // removes node from end of list
        var runner:Node? = self.head
        if runner == nil {  // empty list
            print("Empty")
            self.head = nil
            return nil
        }
        var runner2:Node? = runner
        while (runner?.next != nil) {   // walk list to the end
            runner2 = runner
            runner = runner?.next
        }
        runner2?.next = nil  // delete node
        return runner?.value
    }
}

var theList = List()
theList.addNode(1)
theList.addNode(2)
theList.addNode(3)
theList.addNode(4)
theList.addNode(5)
theList.addNode(6)
while (theList.head != nil) {
    if let a_val = theList.removeNode() {
        print(a_val)
    }
}
