//
//  MainVM.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation


class MainVM: ObservableObject{
    
    //  Навигация по приложению
    @Published var nav: NavVm
    init(nav: NavVm) {
        self.nav = nav
    }
    
    //  Навигация по вкладкам
    @Published var internalNav = ""
    
    
    @Published var isActiveTabs = [true, false, false, false]
    
    func an(){
        internalNav = "an"
        isActiveTabs = [true, false, false, false]
    }
    
    func res(){
        internalNav = "res"
        isActiveTabs = [false, true, false, false]
    }
    
    func sup(){
        internalNav = "sup"
        isActiveTabs = [false, false, true, false]
    }
    
    func user(){
        internalNav = "user"
        isActiveTabs = [false, false, false, true]
    }
}
