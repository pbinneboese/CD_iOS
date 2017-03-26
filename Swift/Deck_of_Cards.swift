import UIKit

struct Card {
    
    var value: String
    var suit: String
    var numerical_value: Int
    
    init(value:String, suit:String, numerical_value:Int){
        
        self.value = value
        self.suit = suit
        self.numerical_value = numerical_value
        
    }
    
}

class Deck {
    
    let values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    let suits = ["Clubs", "Spades", "Diamonds", "Hearts"]
    
    var cards = [Card]()
    
    init(){
//        buildDeck()
    }
    
    private func buildDeck(){
        for i in 0..<suits.count {
            
            for j in 0..<values.count{
                let newCard = Card(value: values[j], suit: suits[i], numerical_value: j)
                cards.append(newCard)
            }
            
        }
    }
    
    func reset(){
        cards = [Card]()
        buildDeck()
    }
    
    func draw() -> Card? {
        return cards.popLast()
    }
    
}

class Player {
    
    var hand = [Card]()
    
    func draw(fromDeck deck: Deck){
        
        if let drawnCard = deck.draw() {
            hand.append(drawnCard)
        }
        
        print("out of cards, friend!")
        
    }
    
    func discard(card:Card) -> Bool {
        
        for i in 0..<hand.count {
            
            if(card.suit == hand[i].suit && card.value == hand[i].value){
                hand.remove(at: i)
                return true
            }
            
        }
        
        return false
        
    }
    
}

let deck1 = Deck()
deck1.draw()