//
//  NavVM.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import Foundation

class NavVm: ObservableObject{
    
    //   Используется в ParentView для навигации между дочерними представлениями
    @Published var currentScreen = "onboarding"
    
    init(){
        
//        if UserDefaults.standard.bool(forKey: "isLoadedYet") == false{
//            currentScreen = "Onboarding"
//            UserDefaults.standard.set(true, forKey: "isLoadedYet")
//        }
//        else{
//            currentScreen = ""
//        }
    }
}
