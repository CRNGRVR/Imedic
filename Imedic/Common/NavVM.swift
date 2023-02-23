//
//  NavVM.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import Foundation

class NavVm: ObservableObject{
    
    @Published var currentScreen = ""
    
    init(){

        if UserDefaults.standard.bool(forKey: "isLoadedYet") == false{
            currentScreen = "Onboarding"
            UserDefaults.standard.set(true, forKey: "isLoadedYet")
        }
        else{
            currentScreen = ""
        }
    }
    
    
    func skipOnboarding(){
        
    }
    
}
