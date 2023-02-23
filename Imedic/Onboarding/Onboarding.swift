//
//  Onboarding.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import SwiftUI

struct Onboarding: View {
    
    @ObservedObject var onboarding_vm = OnboardingVM()
    @ObservedObject var navVm: NavVm
    
    var body: some View {
       
            ZStack{
                Button(action: {
                    navVm.skipOnboarding()
                }, label: {
                    Text(onboarding_vm.btnText)
                })
                .padding(.trailing, 240)
                .padding(.bottom, 140)
                
                Image("onboard_plus")
                    .padding(.leading, 220)
                
                
                VStack{
                    
                    Text(onboarding_vm.currentTitle)
                        .foregroundColor(Color.green)
                        .font(.system(size: 20))
                        .padding(.bottom, 29)
                    
                    Text(onboarding_vm.currentText)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 14))
                        .padding(.bottom, 60)
                    
                    points(pos: onboarding_vm.points)
                        .padding(.bottom, 105)
                    
                }
                .padding(.top, 600)
                
                Image(onboarding_vm.currentImage)
                    .padding(.top, 1100)
            }
            .padding(.bottom, 550)
        
        
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onEnded({value in
                        if value.translation.width < 0{
                            onboarding_vm.incrementPos()
                        }
                        else if value.translation.width > 0{
                            onboarding_vm.decrementPos()
                        }
                    })
            )
    }
}


struct points: View{
    
    var pos: [String]
    
    var body: some View{
        HStack(spacing: 10){
            Image(pos[0])
            Image(pos[1])
            Image(pos[2])
        }
    }
}
