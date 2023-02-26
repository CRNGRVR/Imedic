//
//  CheckingEmailVM.swift
//  Imedic
//
//  Created by Иван on 26.02.2023.
//

import Foundation
import Alamofire

class CheckingEmailVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm) {
        self.nav = nav
    }
    
    @Published var code = "" {
        didSet{
            if code.count == 4{
                check()
            }
        }
    }
    
    @Published var secondsToSend = 59
    var stop = false
    
    //  Запускает таймер до повторной отправки кода, как только загрузилась страница
    func sheduleTimer(){
        
        DispatchQueue.global(qos: .default).async {
            for _ in 0...self.secondsToSend - 1{
                
                if self.stop{
                    return
                }
                
                usleep(1000000)
                
                self.secondsToSend -= 1
            }
            
            if !self.stop{
                self.sendAgain()
            }
        }
    }
    
    func sendAgain(){
        print("Отправка")
    }
    
    func check(){
        
        let headers: HTTPHeaders = ["email": nav.email, "code": code]
        
        AF
            .request("https://medic.madskill.ru/api/signin", method: .post, headers: headers)
            .responseDecodable(of: CheckingEmailOutput.self){ [self]responce in
                
                if responce.value != nil{
                    self.nav.token = responce.value!.token
                    self.stop = true
                    next()
                }
            }
    }
    
    func backToEmail(){
        stop = true
        nav.currentScreen = "reg_auth"
    }
    
    func next(){
        nav.currentScreen = "create_password"
    }
}
