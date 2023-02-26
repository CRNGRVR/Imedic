//
//  CheckingEmailView.swift
//  Imedic
//
//  Created by Иван on 24.02.2023.
//

import SwiftUI

struct CheckingEmailView: View {
    
    @State var t = ""
    //@ObservedObject var vm = CheckEmailVm()
    
    var body: some View {
        VStack{
            Button(action: {}, label: {
                ZStack{
                    Color("tf")
                    Image("back")
                }
            })
            .frame(width: 32, height: 32)
            .cornerRadius(10)
            .padding(.trailing, 300)
            .padding(.bottom, 132)
            
            
            Text("Введите код из E-mail")
                .font(.system(size: 17, weight: .semibold))
                .padding(.bottom, 24)
            
            //TextField("", text: $t)
            //  .keyboardType(.phonePad)
            
                //  До выяснения обстоятельств
                tf(text: $t, placeHolder: "Ну я даже не знаю..")
                    .keyboardType(.phonePad)
                    //.padding(.bottom, 16)
            
            //Text("Отправить код повторно можно\n будет через \(vm.remainingTime) секунд")
                .font(.system(size: 15))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 400)
        .onAppear{
            //vm.waiting()
        }
    }
        
}




struct CheckingEmailView_Previews: PreviewProvider {
    static var previews: some View {
        CheckingEmailView()
    }
}
