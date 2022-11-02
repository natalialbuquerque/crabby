//
//  ContentView.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 28/10/22.
//

import SwiftUI
//import SpriteKit

struct ContentView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("fundo 4 1")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Image("CRAB 1")
                    
                    VStack{
                        NavigationLink(
                            destination: GameView().navigationBarBackButtonHidden(true),
                            label: {
                                Image("play")
                            })
                        ZStack{
                            Image("duas nuvens 2")
                            Image("settings")
                                .padding()
                            Image("mar")
                            //                                .ignoresSafeArea()
                            //                            Image("água")
                            //                                .ignoresSafeArea()
                        }
                    }
                }
            }
            //            .frame(width: 750, height: 1200, alignment: .center)
            //            .background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
