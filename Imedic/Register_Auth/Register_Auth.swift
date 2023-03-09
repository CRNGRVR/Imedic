//
//  Register_Auth.swift
//  Imedic
//
//  Created by Иван on 23.02.2023.
//

import SwiftUI

struct Register_Auth: View {
    
    @ObservedObject var reg_auth_vm: Reg_AuthVM
    init(nav: NavVm){
        reg_auth_vm = Reg_AuthVM(nav: nav)
    }
    
    var body: some View {
        
        VStack(spacing: 5){
            
            HStack(spacing: 16){
                Image("hello")
                Text("Добро пожаловать!")
                    .bold()
                    .font(.system(size: 24))
            }
            .padding(.trailing, 60)
            .padding(.bottom, 23)
            .padding(.top, 50)
            
            Text("Войдите, чтобы пользоваться функциями \nприложения")
                .font(.system(size: 15))
                .frame(width: 335)
                .padding(.trailing, 30)
                .padding(.bottom, 64)
            
            Text("Вход по E-mail")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
                .padding(.trailing, 235)
            
            
            tf(text: $reg_auth_vm.mail, placeHolder: "example@mail.ru")
                .padding(.bottom, 32)
            
            Button(action: {
                reg_auth_vm.next_click()
            }, label: {
                ZStack{
                    Color.blue
                        .opacity(reg_auth_vm.isSendAllowed ? 1 : 0.5)
                    
                    Text("Далее")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            })
            .frame(width: 335, height: 56)
            .cornerRadius(10)
            .padding(.bottom, 230)
            
            
            Text("Или войдите с помощью")
                .foregroundColor(Color.gray)
                .font(.system(size: 15))
                .padding(.bottom, 16)
            
            Button(action: {}, label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                    
                    Text("Войти с Яндекс")
                        .foregroundColor(Color.black)
                        .font(.system(size: 17, weight: .semibold))
                }
                
            })
            .frame(width: 335, height: 60)
            .cornerRadius(10)
            
            
            
        }
        .alert(isPresented: $reg_auth_vm.isError){
            Alert(title: Text("Проблемы c cетью"))
        }
        
        
    }
}
