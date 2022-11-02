//
//  settings.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 02/11/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("BG")
                    .resizable()
                    .ignoresSafeArea()
                Image("mapa")
                    .frame(width: 377, height: 423)
                ZStack{
                    VStack{
                        HStack{
                            NavigationLink(
                                destination: ContentView().navigationBarBackButtonHidden(true),
                                label: {
                                    Image("home1")
                                })
                            NavigationLink(
                                destination: MusicSettings().navigationBarBackButtonHidden(true),
                                label: {
                                    Image("settings")
                                })
                
                        }.frame(alignment: .center)
                        NavigationLink(
                            destination: GameView().navigationBarBackButtonHidden(true),
                            label: {
                                Image("play")
                            })
                    }
                }
                
            }
        }
    }
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
