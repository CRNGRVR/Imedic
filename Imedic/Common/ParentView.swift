//
//  ContentView.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import SwiftUI

struct ParentView: View {
    
    @ObservedObject var navVm = NavVm()
    
    var body: some View {
        
        switch navVm.currentScreen{
            
        case "onboarding":
            Onboarding(nav: navVm)
        case "reg_auth":
            Register_Auth(nav: navVm)
        case "checking_email":
            CheckingEmailView(nav: navVm)
        case "create_password":
            CreatePasswordView()
            
        default: Onboarding(nav: navVm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
