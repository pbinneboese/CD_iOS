//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let cardvalues:[String] = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
let suits:[String] = ["Clubs","Spades","Hearts","Diamonds"]
let deckSize:Int = 52

struct Card {
    var suit:String
    var value:String
    var numeric_value:Int
    init(suit:String, value:String, numeric_value:Int) {
        self.suit = suit
        self.value = value
        self.numeric_value = numeric_value
    }
}

class Deck {
    var cards = [Card]()

    init() {
        self.makeDeck()
    }
    func makeDeck() {
        var a_card:Card
        for i in 0..<suits.count {
            for j in 0..<cardvalues.count {
                a_card = Card(suit:suits[i],value:cardvalues[j], numeric_value:j+1)
                cards.append(a_card)
            }
        }
    }
    func dealCard() ->Card? {
        return cards.popLast()
    }
    func reset() {
        cards = [Card]()    // clear the deck
        makeDeck()
    }
    func shuffle() {
        var rand1:Int
        var rand2:Int
        var temp:Card
        for _ in 0..<Int(deckSize) {
            // swap 2 random cards, 52 times
            rand1 = Int(arc4random_uniform(UInt32(deckSize-1)))
            rand2 = Int(arc4random_uniform(UInt32(deckSize-1)))
            temp = cards[rand1]
            cards[rand1] = cards[rand2]
            cards[rand2] = temp
        }
    }
}

class Player {
    var name:String?
    var hand = [Card]()

    init() {
        self.name = "Card Shark"
        self.hand = [Card]()
    }
    func drawCard(deck:Deck) ->Card? {
        if let theCard = deck.dealCard() {
            hand.append(theCard)
            return theCard
        }
        else {
            return nil
        }
    }
    func discard(card:Card, deck:Deck) ->Bool {
        for i in 0..<hand.count {
            if (hand[i].value == card.value) && (hand[i].suit == card.suit) {
                let card = hand.remove(at: i)
                deck.cards.append(card)
                return true
            }
        }
        return false
    }
}

// Insert Code Here
let a_deck = Deck()
print("Initialized")
for i in 0..<deckSize {
    print(a_deck.cards[i].value,a_deck.cards[i].suit)
}
print("\nShuffled")
a_deck.shuffle()
for i in 0..<deckSize {
    print(a_deck.cards[i].value,a_deck.cards[i].suit)
}
print("Deck has \(a_deck.cards.count) cards")

print("\nDeal Hand")
let a_player = Player()
for i in 0..<5 {
    a_player.drawCard(deck:a_deck)
    print(a_player.hand[i].value,a_player.hand[i].suit)
}
print("Hand has \(a_player.hand.count) cards")
print("Deck has \(a_deck.cards.count) cards")

print("\nDiscard")
var a_card = Card(suit:"Diamonds", value:"K", numeric_value:11)
if a_player.discard(card:a_card, deck:a_deck) {
    print("\(a_card.value) of \(a_card.suit) was in hand")
}
else {
    print("\(a_card.value) of \(a_card.suit) - no match")
}

for i in 0..<a_player.hand.count {
    a_card = a_player.hand[0]
    print(a_card.value, a_card.suit)
    a_player.discard(card:a_card, deck:a_deck)
}
print("Hand has \(a_player.hand.count) cards")
print("Deck has \(a_deck.cards.count) cards")
