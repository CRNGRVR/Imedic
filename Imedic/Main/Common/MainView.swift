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
            
            VStack(spacing: 0){
                VStack{
                    switch mainVM.internalNav{
                    case "an":
                        AnCartParentView(nav: mainVM.nav)
                    case "user":
                        UserView()
                    case "sup":
                        SupView()
                            
                    case "res":
                        ResView()
                            .frame(height: 670)
                        
                    default: Color.white
                            .padding(.top, 40)
                    }
                }
                .frame(height: UIScreen.main.bounds.size.height - 100)
                
            
                    
                //  Таббар
                //  Ну типо
                ZStack{
                    Color.white
                        .frame(width: UIScreen.main.bounds.width, height: 100)

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
                    .ignoresSafeArea(.all)
                }
               
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(nav: NavVm())
    }
}
