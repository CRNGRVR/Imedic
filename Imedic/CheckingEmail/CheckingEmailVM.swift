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
    
    @Published var secondsToSend = 90
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
    
    @Published var isErr = false
    
    func sendAgain(){
        check()
    }
    
    func check(){
        
        let headers: HTTPHeaders = ["email": nav.email, "code": code]
        
        AF
            .request("https://medic.madskill.ru/api/signin", method: .post, headers: headers)
            .responseDecodable(of: CheckingEmailOutput.self){responce in
                
                if responce.value != nil{
                    self.nav.token = responce.value!.token
                    
                    KeyChainManager.shared.saveToken(token: responce.value!.token)
                    
                    self.stop = true
                    self.next()
                    
                    print(KeyChainManager.shared.retreiveToken())
                }
                else{
                    self.isErr = true
                }
            }
    }
    
    func backToEmail(){
        stop = true
        nav.currentScreen = "reg_auth"
    }
    
    func next(){
//        if nav.isPasswordEntered{
//            nav.currentScreen = "create_patient"
//        }
//        else{
//            nav.currentScreen = "create_password"
//        }
        
        if KeyChainManager.shared.isHavedPassword(){
            nav.currentScreen = "create_patient"
        }
        else{
            nav.currentScreen = "create_password"
        }
    }
}
