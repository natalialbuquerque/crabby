//
//  GameView.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SwiftUI
import SpriteKit

struct BubbleData: Identifiable {
    var id = UUID()
    var bubbleImage: UIImage
    var operation: Int
}

class DataModel: ObservableObject {
    @Published var dataSet: [BubbleData] = [
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble1"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble2"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble3"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble4"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble5"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble6"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble7"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble8"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble9"), operation: 0),
        BubbleData(bubbleImage: UIImage(imageLiteralResourceName: "bubble10"), operation: 0), // até aqui foi soma
    ]
}

let gameScene = GameScene()

struct GameView: View {
    @StateObject var dataModel = DataModel()
    
    var body: some View {
        SpriteView(scene: GameScene(size: CGSize(width: 750, height: 1335)))
            .ignoresSafeArea()

        
        }
    }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
