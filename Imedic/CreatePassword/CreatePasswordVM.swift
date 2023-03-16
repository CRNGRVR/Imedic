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
        
        KeyChainManager.shared.savePassword(pass: password)
        
        
    //UserDefaults.standard.set(password, forKey: "password")
        
//  Удаление данных по ключу genericPassword
//  Для отладки
//
//        let query = [kSecClass: kSecClassGenericPassword] as CFDictionary
//        let res = SecItemDelete(query)
        
        
//  Добавление записи
//  Адаптация
//
//        let kchSaveQuerry = [kSecClass: kSecClassGenericPassword, kSecValueData: password.data(using: .utf8)!] as CFDictionary
//        print(SecItemAdd(kchSaveQuerry, nil))
//
//        //  Поиск записи
//        let kchSearchQuerry = [kSecClass: kSecClassGenericPassword, kSecReturnAttributes: true, kSecReturnData: true] as CFDictionary
//        var resp: AnyObject?
//
//        print(SecItemCopyMatching(kchSearchQuerry, &resp))
//        if let result = resp as? NSDictionary, let pass = result[kSecValueData] as? Data{
//            print(String(decoding: pass, as: UTF8.self))
//        }
//        else{
//            print("no")
//        }
        
        
//Удаление
//        let query = [
//             kSecClass: kSecClassCertificate,
//             kSecValueData: password.data(using: .utf8)!
//        ] as CFDictionary
//
//        let res = SecItemDelete(query)
//
//
//
//Добавление
//        let keychainAddQuery = [kSecValueData: password.data(using: .utf8)!, kSecClass: kSecClassCertificate] as CFDictionary
//
//        let status = SecItemAdd(keychainAddQuery, nil)
//        print("Operation finished with status: \(status)")
//
//
//
//Поиск
//       let keychainSearchItem = [
//             //kSecValueData: "0011".data(using: .utf8)!,
//             kSecClass: kSecClassCertificate,
//             kSecReturnAttributes: true,
//             kSecReturnData: true
//         ] as CFDictionary
//
//         var ref: AnyObject?
//
//         let status1 = SecItemCopyMatching(keychainSearchItem, &ref)
//         if let result = ref as? NSDictionary, let passwordData = result[kSecValueData] as? Data {
//             print("Operation finished with status: \(status1)")
//             print(result)
//             let str = String(decoding: passwordData, as: UTF8.self)
//             print(str)
//         }else{
//             print("Нет данных")
//         }
    }
    
    
    func next(){
        nav.currentScreen = "create_patient"
    }
    
    func skip(){
        next()
    }
}
