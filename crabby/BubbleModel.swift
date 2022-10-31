//
//  BubbleModel.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 29/10/22.
//
//
import SwiftUI

class BubbleModel: ObservableObject {
    @Published var bubbleGames: [BubbleGame] = []
    
    init() {
        bubbleGames = makeBubbleGames()
    }
    
    private func makeBubbleGames() -> [BubbleGame] {
        return [BubbleGame(id: 0, operation: "+1", image: "bubble1"),
                BubbleGame(id: 1, operation: "+2", image: "bubble2"),
                BubbleGame(id: 2, operation: "+3", image: "bubble3"),
                BubbleGame(id: 3, operation: "+4", image: "bubble4"),
                BubbleGame(id: 4, operation: "+5", image: "bubble5"),
                BubbleGame(id: 5, operation: "+6", image: "bubble6"),
                BubbleGame(id: 6, operation: "+7", image: "bubble7"),
                BubbleGame(id: 7, operation: "+8", image: "bubble8"),
                BubbleGame(id: 8, operation: "+9", image: "bubble9"),
                BubbleGame(id: 9, operation: "+10", image: "bubble10"),
   ]
        
    }
}

class BubbleGame: ObservableObject, Identifiable {
    @Published var id: Int
    @Published var operation: String
    @Published var image: String
    
    init(id: Int,
         operation: String,
         image: String
    ) {
        self.id = id
        self.operation = operation
        self.image = image
    }
}
