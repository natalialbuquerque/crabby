//
//  Persistencia.swift
//  crabby
//
//  Created by Natália Pessoa de Azevedo Albuquerque on 02/11/22.
//

import SwiftUI

class ViewManager: ObservableObject{
    @Published var isGameRuning = false
    @Published var showingHomePage = false
    @Published var showingLevelPage = false
    
    func didUserTapStartButton(){
        showingHomePage = false
        showingLevelPage = true
    }
    
    func didUserTapGoBackToHomePage(){
        showingLevelPage = false
        showingHomePage = true
    }
    
    func didUserTapToStartGame(){
        showingLevelPage = false
        isGameRuning = true
    }
    
    func didUserTapGoToMenu(){
        isGameRuning = false
        showingLevelPage = false
    }
}
