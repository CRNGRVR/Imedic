//
//  KeyChainManager.swift
//  Imedic
//
//  Created by Иван on 16.03.2023.
//

import Foundation

struct KeyChainManager{
    
    static let shared = KeyChainManager()
    
    init(){
        //deletePassword()
    }
    
    func savePassword(pass: String){
        let kchSaveQuerry = [kSecClass: kSecClassGenericPassword, kSecValueData: pass.data(using: .utf8)!] as CFDictionary
        SecItemAdd(kchSaveQuerry, nil)
    }
    
    func deletePassword(){
        let query = [kSecClass: kSecClassGenericPassword] as CFDictionary
        SecItemDelete(query)
        
        let query1 = [kSecClass: kSecClassCertificate] as CFDictionary
        SecItemDelete(query1)
    }
    
    func isHavedPassword() -> Bool{
        let kchSearchQuerry = [kSecClass: kSecClassGenericPassword, kSecReturnAttributes: true, kSecReturnData: true] as CFDictionary
        var resp: AnyObject?
        
        print(SecItemCopyMatching(kchSearchQuerry, &resp))
        
        if let result = resp as? NSDictionary, let pass = result[kSecValueData] as? Data{
            print(String(decoding: pass, as: UTF8.self))
            return true
        }
        else{
            print("нет пароля")
            return false
        }
    }
    
    
    func saveToken(token: String){
        let kchSaveQuerry = [kSecClass: kSecClassCertificate, kSecValueData: token.data(using: .utf8)!] as CFDictionary
        SecItemAdd(kchSaveQuerry, nil)
    }
    
    func retreiveToken() -> String?{
        
        let kchSearchQuerry = [kSecClass: kSecClassCertificate, kSecReturnAttributes: true, kSecReturnData: true] as CFDictionary
        var resp: AnyObject?
        
        print(SecItemCopyMatching(kchSearchQuerry, &resp))
        
        if let result = resp as? NSDictionary, let pass = result[kSecValueData] as? Data{
            return String(decoding: pass, as: UTF8.self)
        }
        else{
            return nil
        }
    }
}
