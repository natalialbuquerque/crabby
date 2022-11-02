//
//  MusicSettings.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 02/11/22.
//

import SwiftUI

struct MusicSettings: View {
    @State private var musicCount: CGFloat = 5
    @State private var sfxCount: CGFloat = 5
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
                        NavigationLink(
                            destination: SettingsView().navigationBarBackButtonHidden(true),
                            label: {
                                Image("X")
                            })
                        Image("Music")
                        Slider(value: $musicCount, in: CGFloat(0)...CGFloat(10))
                            .lineLimit(10)
                            .padding()
                        Image("SFX")
                        Slider(value: $sfxCount, in: CGFloat(0)...CGFloat(10))
                            .padding()
                            
                    }.frame(alignment: .center)
                }
            }
        }
    }
}

struct MusicSettings_Previews: PreviewProvider {
    static var previews: some View {
        MusicSettings()
    }
}
