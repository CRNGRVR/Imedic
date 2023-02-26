//
//  NavVM.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import Foundation

class NavVm: ObservableObject{
    
    //   Используется в ParentView для навигации между дочерними представлениями
    @Published var currentScreen: String
    
    
    init(){
        
        //  onboarding показывается только при первом запуске
        if UserDefaults.standard.bool(forKey: "isLoadedYet") == false{
            currentScreen = "onboarding"
            UserDefaults.standard.set(true, forKey: "isLoadedYet")
        }
        else{
            currentScreen = "reg_auth"
        }
    }
    
    
    
    
    
    //  Временно здесь ещё и email ака глобальная переменная...
    @Published var email = ""
    @Published var token = ""

}
