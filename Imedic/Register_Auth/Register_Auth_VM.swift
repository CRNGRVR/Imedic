//
//  Register_Auth_VM.swift
//  Imedic
//
//  Created by Иван on 23.02.2023.
//

import Foundation
import Alamofire

class Reg_AuthVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm) {
        self.nav = nav
    }
    
    @Published var mail = "" {
        didSet{
            checkPattern()
        }
    }
    
    @Published var isSendAllowed = false
    
    func checkPattern(){
        
        //  Разрешена ли отправка
        isSendAllowed = false
        
        //  Все допустимые символы
        let allowedSymbols = "1234567890qwertyuiopasdfghjklzxcvbnm"
        
        //  Для проверки одного символа на соответствие
        var isCharAllowedInIteration = false
        
        //  Кол-во собачек и точек
        var countDot = 0
        var countPes = 0
        
        
        for sym in mail{
            
            isCharAllowedInIteration = false
            
            //  Сравнение одного символа со списком допустимых
            for allowedSym in allowedSymbols{
                
                if sym == allowedSym{
                    isCharAllowedInIteration = true
                    break
                }
                
                //  Для собачки и точки правила те же
                else if sym == "@"{
                    countPes += 1
                    isCharAllowedInIteration = true
                    break
                }
                else if sym == "."{
                    countDot += 1
                    isCharAllowedInIteration = true
                    break
                }
                
                //  Если символ недопустим, его проверка заканчивается
            }
            
    
            if !isCharAllowedInIteration{
                return
            }
            
            //  Выполнение доходит до сюда только если все символы допускаются
        }
        
        if mail != "" && countPes == 1 && countDot > 0{
            isSendAllowed = true
        }
        
    }
    
    func next_click(){
        
        if isSendAllowed{
            
            let headers: HTTPHeaders = ["email" : mail]
            
            AF
                .request("https://medic.madskill.ru/api/sendCode", method: .post ,headers: headers)
                .responseDecodable(of: SendCodeOutput.self){responce in
                    if responce.value != nil{
                        
                        if responce.response?.statusCode == 200{
                            
                            self.nav.email = self.mail //Передача в другое представление
                            self.nav.currentScreen = "checking_email"
                        }
                    }
                    else{
                        print("Error")
                    }
                }
        }
    }
}
