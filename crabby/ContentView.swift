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
                Image("Group 21")
                    .resizable()
                    .ignoresSafeArea()
                    
                VStack{
                    Image("CRAB 1")
                        .padding(.top, -50)
                    VStack{
                        NavigationLink(
                            destination: GameView().navigationBarBackButtonHidden(true),
                            label: {
                                Image("play")
                                    .padding(.top, -50)
                            })
                        NavigationLink(
                            destination: SettingsView().navigationBarBackButtonHidden(true),
                            label: {
                                Image("settings")
                                    
                            })
                        
                    }
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
