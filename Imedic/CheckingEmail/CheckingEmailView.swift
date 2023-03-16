//
//  CheckingEmailView.swift
//  Imedic
//
//  Created by Иван on 24.02.2023.
//

import SwiftUI

struct CheckingEmailView: View {
    
    @ObservedObject var checkingemailVM: CheckingEmailVM
    init(nav: NavVm){
        self.checkingemailVM = CheckingEmailVM(nav: nav)
    }
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {checkingemailVM.backToEmail()}, label: {
                    ZStack{
                        Color("tf")
                        Image("back")
                    }
                })
                .frame(width: 32, height: 32)
                .cornerRadius(10)
                .padding(.leading, 20)
                .padding(.top, 24)
                
                Spacer()
            }
            
            Spacer()
            
            Text("Введите код из E-mail")
                .font(.system(size: 17, weight: .semibold))
                .padding(.bottom, 24)
            
            //  До выяснения обстоятельств
            tf(text: $checkingemailVM.code, placeHolder: "Ну я даже не знаю..")
                    .keyboardType(.phonePad)
                    .padding(.bottom, 16)
            
            Text("Отправить код повторно можно\n будет через \(checkingemailVM.secondsToSend) секунд")
                .font(.system(size: 15))
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.bottom, 250)
            
            
            Spacer()
        }
        .onAppear{
            checkingemailVM.sheduleTimer()
        }
        .alert(isPresented: $checkingemailVM.isErr){
            Alert(title: Text("Проблемы c cетью"))
        }
    }
    
}


struct prewiew1: PreviewProvider{
    static var previews: some View{
        CheckingEmailView(nav: NavVm())
    }
}
