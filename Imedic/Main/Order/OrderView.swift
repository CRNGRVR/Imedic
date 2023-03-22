//
//  OrderView.swift
//  Imedic
//
//  Created by Иван on 13.03.2023.
//

import SwiftUI

struct OrderView: View {
    
    @ObservedObject var orderVM: OrderVM
    init(anCartVM: AnCartVM){
        orderVM = OrderVM(anVM: anCartVM)
    }
    
    var body: some View {
        VStack{
            Button(action: {orderVM.getl()}, label: {Text("shirota & dolgota")})
            
            Text("Оформление заказа")
             
            ScrollView(.vertical){
                VStack{
                    
                    Text("Адрес заказа")
                    
                    Text("Дата и время")
                    
                    Text("Кто будет сдавать анализы?")
                    
                    
                }
            }
        }
        .onAppear{
            orderVM.request()
        }
        
        
    }
}


struct adrView: View{
    
    @State var txt = ""
    @State var isOn = true
    
    
    var body: some View{
        VStack{
            HStack{
                Text("Адрес сдачи анализов")
                
                Button(action: {}, label: {
                    Image("map")
                })
            }
            
            Text("Ваш адрес")
            
            tfWithSize(text: $txt, placeholder: "", width: 335, height: 48)
            
            HStack{
                VStack{
                    Text("Долгота")
                    tfWithSize(text: $txt, placeholder: "", width: 130, height: 48)
                }
                
                VStack{
                    Text("Широта")
                    tfWithSize(text: $txt, placeholder: "", width: 130, height: 48)
                }
                
                VStack{
                    Text("Высота")
                    tfWithSize(text: $txt, placeholder: "", width: 50, height: 48)
                }
            }
            
            
            HStack{
                VStack{
                    Text("Квартира")
                    tfWithSize(text: $txt, placeholder: "", width: 100, height: 48)
                }
                
                VStack{
                    Text("Подъезд")
                    tfWithSize(text: $txt, placeholder: "", width: 100, height: 48)
                }
                
                VStack{
                    Text("Этаж")
                    tfWithSize(text: $txt, placeholder: "", width: 100, height: 48)
                }
            }
            
            VStack{
                Text("Домофон")
                tfWithSize(text: $txt, placeholder: "", width: 335, height: 48)
            }
            
            HStack{
                Text("Сохранить этот адрес?")
                Toggle(isOn: $isOn, label: {})
            }
            
            Button(action: {}, label: {
                ZStack{
                    Color.blue
                    
                    Text("Подтвердить")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            })
            .frame(width: 335, height: 56)
            .cornerRadius(10)
        }
    }
}


struct datetime: View{
    
    var body: some View{
        VStack{
            
        }
    }
}


struct tfWithSize: View{
    
    @Binding var text: String
    var placeholder: String
    
    var width: CGFloat
    var height: CGFloat
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
                .background(Color("tf"))
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .padding(.leading, 10)
        }
        .frame(width: width, height: height)
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        //OrderView()
        adrView()
    }
}
