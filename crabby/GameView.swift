//
//  GameView.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
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
