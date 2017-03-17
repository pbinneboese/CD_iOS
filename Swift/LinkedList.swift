
import UIKit

class Node {
    
    var key:Int
    
    var next:Node?
    
    init(_ key:Int){
        self.key = key
    }
}

class LinkedList {
    
    var head:Node? = nil
    
}


extension LinkedList {
    
    func traverse( callback:(_ node:Node) ->Void ) -> Void {
        if(self.head == nil){
            return
        }
        var current = self.head
        
        while(current?.next != nil){
            callback(current!)
            current = current?.next
        }
        return
    }
    
    func reduce( cb:@escaping (_ val1:Int, _ val2:Int) -> Int ) -> Int {
        
        var value = 0
        
        self.traverse(callback: {
            node in
            value += cb(node.key, (node.next?.key)!)
        })
        
        return value
        
    }
    
    func add(_ key: Int) -> Void {
        
        if(self.head == nil){
            self.head = Node(key)
        }
        
        var current = self.head
        
        while(current?.next != nil){
            current = current?.next
        }
        
        current?.next = Node(key)
        
    }
    
}

let list1 = LinkedList()

for i in 0...10 {
        list1.add(Int(arc4random_uniform(100)))
}

list1.reduce(cb: {
    val1, val2 in
    return val1 + val2
})

list1.traverse(callback: {
    node in
    
    print(node.key)
    print(type(of: node.key))
    
    
})