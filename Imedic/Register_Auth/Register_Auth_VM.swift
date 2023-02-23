//
//  Register_Auth_VM.swift
//  Imedic
//
//  Created by Иван on 23.02.2023.
//

import Foundation

class Reg_Auth_VM: ObservableObject{
    
    
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
}
