//
//  CreatePatientView.swift
//  Imedic
//
//  Created by Иван on 25.02.2023.
//

import SwiftUI

struct CreatePatientView: View {
    
    @ObservedObject var createPatientVm: CreatePatientVM
    init(nav: NavVm){
        createPatientVm = CreatePatientVM(nav: nav)
    }
    
    var body: some View {
       
        
        VStack{
            HStack{
                
                Text("Создание карты \nпациента")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.leading, 20)
                    .frame(minHeight: 60, alignment: .topLeading)
                
                Spacer()
                
                Button(action: {createPatientVm.skip()}, label: {
                    Text("Пропустить")
                        .font(.system(size: 15))
                })
                .padding(.trailing, 20)
            }
            .padding(.top, 40)
            //.padding(.bottom, 16)
            
            HStack{
                Text("Без карты пациента вы не сможете заказать\nанализы.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    //.padding(.bottom, 8)
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            Spacer()
                .frame(maxHeight: 8)
            
            HStack{
                Text("В картах пациентов будут храниться результаты анализов вас и ваших близких.")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .lineSpacing(2)
                    .padding(.leading, 20)
                
                Spacer()
            }
            
            Spacer()
                .frame(maxHeight: 32)
            
            VStack(spacing: 24){
                tf(text: $createPatientVm.name, placeHolder: "Имя")
                tf(text: $createPatientVm.otch, placeHolder: "Отчество")
                tf(text: $createPatientVm.fam, placeHolder: "Фамилия")
                tf(text: $createPatientVm.date, placeHolder: "Дата рождения")
                tf(text: $createPatientVm.pol, placeHolder: "Пол")
            }
           
            Spacer()
                //.frame(minHeight: 24)
            
            Button(action: {createPatientVm.clickSend()}, label: {
                ZStack{
                    Color.blue
                        .opacity(createPatientVm.isSetCardAllowed ? 1 : 0.5)
                    
                    Text("Создать")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            })
            .frame(width: 335, height: 56)
            .cornerRadius(10)
            
            Spacer()
                //.frame(minHeight: 30)
            
        }
    }
}

struct prewiew2: PreviewProvider{
    static var previews: some View{
        CreatePatientView(nav: NavVm())
    }
}
