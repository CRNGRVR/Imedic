//
//  CartView.swift
//  Imedic
//
//  Created by Иван on 03.03.2023.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var anCartVM: AnCartVM = AnCartVM(nav: NavVm())
    
    var body: some View {
        VStack{
            Button(action: {
                anCartVM.anCartNav = "list"
            }, label: {
                ZStack{
                    Color("tf")
                    Image("back")
                }
            })
            .frame(width: 32, height: 32)
            .cornerRadius(10)
            .padding(.trailing, 310)
            .padding(.top, 20)
            .padding(.bottom, 24)
            
            HStack(spacing: 210){
                Text("Корзина")
                    .font(.system(size: 24, weight: .bold))
                
                Button(action: {anCartVM.deleteAllItem()}, label: {
                    Image("trash")
                })
            }
            .padding(.bottom, 32)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 16){
                    
                    ForEach(anCartVM.cart){item in
                        CartCard(anCartVM: anCartVM, id: item.id, title: item.name, price: item.price, count: item.count)
                    }
                    
                    HStack(spacing: 172){
                        Text("Сумма")
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("\(anCartVM.summ) ₽")
                            .frame(width: 90, alignment: .trailing)
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(.top, 40)
                }
            }
            
            Button(action: {anCartVM.goToOrder()}, label: {
                ZStack{
                    Color("active")
                        .frame(width: 335, height: 56)
                        .cornerRadius(10)
                    
                    Text("Перейти к оформлению заказа")
                        .foregroundColor(Color.white)
                        .font(.system(size: 17, weight: .semibold))
                }
            })
        }
    }
}


struct CartCard: View{
    
    @ObservedObject var anCartVM: AnCartVM
    
    var id: Int
    var title: String
    var price: String
    var count: Int
    
    var body: some View{
        ZStack{
            Color("card")
                .cornerRadius(10)
                
            
            VStack{
                
                HStack{
                    Text(title)
                        .font(.system(size: 16))
                        .frame(width: 275, height: 60, alignment: .topLeading)
                    
                    Button(action: {anCartVM.removeFromCartByCatalogId(id: id)}, label: {
                        Image("X")
                    })
                    .padding(.bottom, 50)
                }
                
                HStack{
                    Text("\(price) ₽")
                        .font(.system(size: 17))
                        .frame(width: 70, alignment: .leading)
                        .padding(.trailing, 15)
                    
                    Text("\(String(count)) \(anCartVM.wordWithCorrectEnding(count: count))")
                        .font(.system(size: 15))
                        .frame(width: 110, alignment: .trailing)
                        .padding(.trailing, 16)
                    
                    ZStack{
                        Color("tf")
                            .cornerRadius(10)
                        
                        HStack{
                            Button(action: {anCartVM.decreaseItemInCart(id: id)}, label: {
                                Image("-")
                            })
                            
                            Image("Divider")
                            
                            Button(action: {anCartVM.increaseItemInCart(id: id)}, label: {
                                Image("+")
                            })
                        }
                    }
                    .frame(width: 64, height: 32)
                }
            }
        }
        .frame(width: 335, height: 138)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        //CartCard(anCartVM: AnCartVM(nav: NavVm()), id: 1, title: "ПЦР-тест на коронавирус SARS-CoV-2, мазок (PCR, Coronavirus SARS-CoV-2, nasopharyngeal and oropharyngeal smear)", price: "31345", count: 2)
        
        CartView()
    }
}
