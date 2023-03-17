//
//  OnboardingTDD.swift
//  Imedic
//
//  Created by Иван on 16.03.2023.
//

import SwiftUI

struct OnboardingTDD: View {
    
    @ObservedObject var onb: OnboardingTDDVM
    
    init(nav: NavVm){
        onb = OnboardingTDDVM(nav: nav)
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {
                    onb.next()
                }, label: {
                    Text(onb.buttonText)
                        .font(.system(size: 20))
                })
                .padding(.leading, 30)
                
                Spacer()
                
                Image("onboard_plus")
            }
            
            Spacer()
            
            Text(onb.queue[0].title)
                .foregroundColor(Color.green)
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
                .frame(maxHeight: 20)
            
            Text(onb.queue[0].descr)
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
            
            Spacer()
            
            HStack(spacing: 8){
                Image("active_point")
                Image("active_point")
                Image("active_point")
            }
            
            Spacer()
            
            Image(onb.queue[0].image)
            
            Spacer()
        }
        .gesture(DragGesture(minimumDistance: 50).onEnded{value in
            
            if value.translation.width < 0{
                onb.nextBoard()
            }
        })
    }
}

//struct OnboardingTDD_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingTDD()
//    }
//}
