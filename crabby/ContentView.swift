//
//  ContentView.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        NavigationView{
              ZStack{
                VStack{
                  Image("Group 4")
                    .offset(y:-100)
                  NavigationLink(
                  destination: GameView().navigationBarBackButtonHidden(true),
                  label: {
                    Image("Group 5")
                      .offset(y:-120)
                  })
                    
                  Image("Group 6")
                    .offset(y:-80)
                }
              }
              .frame(width: 750, height: 1200, alignment: .center)
              .background(.white)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
