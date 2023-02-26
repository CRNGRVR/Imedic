//
//  CreatePatientView.swift
//  Imedic
//
//  Created by Иван on 25.02.2023.
//

import SwiftUI

struct CreatePatientView: View {
    
    @State var zaglushka = ""
    
    var body: some View {
       
        
        VStack{
            HStack{
                Text("Создание карты \nпациента")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.trailing, 55)
                
                Button(action: {}, label: {
                    Text("Пропустить")
                        .font(.system(size: 15))
                })
            }
            .padding(.bottom, 16)
            
            Text("Без карты пациента вы не сможете заказать\nанализы.")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
                .padding(.bottom, 8)
                .padding(.trailing, 30)
                

            
            Text("В картах пациентов будут храниться результаты анализов вас и ваших близких.")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
                .padding(.bottom, 32)
                .lineSpacing(2)
            
            VStack(spacing: 24){
                tf(text: $zaglushka, placeHolder: "Имя")
                tf(text: $zaglushka, placeHolder: "Отчество")
                tf(text: $zaglushka, placeHolder: "Фамилия")
                tf(text: $zaglushka, placeHolder: "Дата рождения")
                tf(text: $zaglushka, placeHolder: "Пол")
            }
            .padding(.bottom, 48)
            
            Button(action: {}, label: {
                ZStack{
                    Color.blue
                        .opacity(1)
                    
                    Text("Создать")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            })
            .frame(width: 335, height: 56)
            .cornerRadius(10)
            
        }
    }
}

struct CreatePatientView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePatientView()
    }
}
