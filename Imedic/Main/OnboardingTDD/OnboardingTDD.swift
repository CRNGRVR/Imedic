//
//  OnboardingTDD.swift
//  Imedic
//
//  Created by Иван on 16.03.2023.
//

import SwiftUI

struct OnboardingTDD: View {
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {}, label: {
                    Text("Пропустить")
                        .font(.system(size: 20))
                })
                .padding(.leading, 30)
                
                Spacer()
                
                Image("onboard_plus")
            }
            
            Spacer()
            
            Text("Анализы")
                .foregroundColor(Color.green)
                .font(.system(size: 20, weight: .semibold))
            
            Spacer()
                .frame(maxHeight: 20)
            
            Text("Экспресс сбор и получение проб")
                .font(.system(size: 14))
                .foregroundColor(Color.gray)
            
            Spacer()
            
            HStack(spacing: 8){
                Image("active_point")
                Image("active_point")
                Image("active_point")
            }
            
            Spacer()
            
            Image("onboard1")
            
            Spacer()
        }
    }
}

struct OnboardingTDD_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTDD()
    }
}
