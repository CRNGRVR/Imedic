//
//  MainView.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var mainVM: MainVM
    init(nav: NavVm){
        mainVM = MainVM(nav: nav)
    }
    
    var body: some View {
        ZStack{
            
            Color.blue
            
            switch mainVM.internalNav{
            case "an":
                AnView(nav: mainVM.nav) //  Возможно нав там не нужен
                    .padding(.top, 40)
            case "user":
                UserView()
                
            default: AnView(nav: mainVM.nav)
                    .padding(.top, 40)
            }
                
            //  Таббар
            ZStack{
                Color.white
                    .frame(width: 390, height: 100)
                
                HStack(spacing: 27){
                    
                    Button(action: {mainVM.an()}, label: {
                        VStack{
                            Image(mainVM.isActiveTabs[0] ? "a-an" : "non-an")
                            Text("Анализы")
                                .foregroundColor(mainVM.isActiveTabs[0] ? Color.blue : Color.gray)
                                .font(.system(size: 12))
                        }
                    })
                    Button(action: {mainVM.res()}, label: {
                        VStack{
                            Image("res")
                            Text("Результаты")
                                .foregroundColor(mainVM.isActiveTabs[1] ? Color.blue : Color.gray)
                                .font(.system(size: 12))
                        }
                    })
                    Button(action: {mainVM.sup()}, label: {
                        VStack{
                            Image("sup")
                            Text("Поддержка")
                                .foregroundColor(mainVM.isActiveTabs[2] ? Color.blue : Color.gray)
                                .font(.system(size: 12))
                        }
                    })
                    Button(action: {mainVM.user()}, label: {
                        VStack{
                            Image(mainVM.isActiveTabs[3] ? "a-user" : "non-user")
                            Text("Профиль")
                                .foregroundColor(mainVM.isActiveTabs[3] ? Color.blue : Color.gray)
                                .font(.system(size: 12))
                        }
                    })
                }
                .padding(.bottom, 20)
            }
            .ignoresSafeArea(.all)
            .padding(.top, 745)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(nav: NavVm())
    }
}
