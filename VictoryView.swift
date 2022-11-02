//
//  VictoryView.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 02/11/22.
//

import SwiftUI

struct VictoryView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("victory")
                NavigationLink(
                    destination: ContentView().navigationBarBackButtonHidden(true),
                    label: {
                        Image("home1")
                            .frame(alignment: .center)
                    })
            }
        }
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView()
    }
}
