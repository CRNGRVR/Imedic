//
//  Register_Auth.swift
//  Imedic
//
//  Created by Иван on 23.02.2023.
//

import SwiftUI

struct Register_Auth: View {
    
    @ObservedObject var reg_auth_vm = Reg_Auth_VM()
    
    var body: some View {
        
        VStack{
            TextField("Mail", text: $reg_auth_vm.mail)
            Button(action: {}, label: {
                Color.blue
                    .opacity(reg_auth_vm.isSendAllowed ? 1 : 0.5)
            })
        }
        
        
    }
}

struct Register_Auth_Previews: PreviewProvider {
    static var previews: some View {
        Register_Auth()
    }
}
