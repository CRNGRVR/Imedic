//
//  CreatePasswordVM.swift
//  Imedic
//
//  Created by Иван on 24.02.2023.
//

import Foundation

class CreatePasswordVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm){
        self.nav = nav
    }
    
    @Published var pass_points = [false, false, false, false]
    @Published var password = ""
    
    var index = 0
    
    func numKeyPressed(key: Int){
        
        if index < 4 && key != -1{
            password.append(String(key))
            pass_points[index] = true
            index += 1
        }
        else if index > 0 && key == -1{
            //  Удаление последнего элемента в строке
            password.remove(at: password.index(before: password.endIndex))
            pass_points[index - 1] = false
            index -= 1
        }
        
        if index == 4{
            
            //  Задержка, чтобы пользователь увидел результат заполнения
            DispatchQueue.global(qos: .default).async{
                usleep(1000000) //  1 секунда
                self.save()
                self.next()
            }
        }
    }
    
    func save(){
        UserDefaults.standard.set(password, forKey: "password")
    }
    
    func next(){
        nav.currentScreen = "create_patient"
    }
    
    func skip(){
        next()
    }
}
