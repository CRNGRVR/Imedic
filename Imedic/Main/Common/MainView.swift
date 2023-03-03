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
            
            //Color.blue
            
            VStack(spacing: 0){
                switch mainVM.internalNav{
                case "an":
                    AnCartParentView(nav: mainVM.nav)
                case "user":
                    UserView()
                    
                default: Color.white
                        .padding(.top, 40)
                }
                    
                //  Таббар
                ZStack{
                    Color.white
                        .frame(width: 390, height: 60)
                    
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
                    .padding(.top, 20)
                }
                .ignoresSafeArea(.all)
                //.padding(.top, 745)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(nav: NavVm())
    }
}
