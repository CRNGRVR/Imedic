//
//  CreatePatientVM.swift
//  Imedic
//
//  Created by Иван on 26.02.2023.
//

import Foundation
import Alamofire

class CreatePatientVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm) {
        self.nav = nav
    }
    
    @Published var name = "" {didSet{checkForFillAll()}}
    @Published var otch = "" {didSet{checkForFillAll()}}
    @Published var fam = ""  {didSet{checkForFillAll()}}
    @Published var date = "" {didSet{checkForFillAll()}}
    @Published var pol = ""  {didSet{checkForFillAll()}}
    
    @Published var isSetCardAllowed = false
    
    //  Проверка всех полей на заполнение
    func checkForFillAll(){
        
        if name != "" && otch != "" && fam != "" && date != "" && pol != ""{
            isSetCardAllowed = true
        }
        else{
            isSetCardAllowed = false
        }
    }
    
    
    func clickSend(){
        
        if isSetCardAllowed{
            pushToServer()
        }
    }
    
    
    func pushToServer(){
        
        let params = ["firstname": name, "lastname": fam, "middlename": otch, "bith": date, "pol": pol, "image": "0"]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(nav.token)"]
        
        AF
            .request("https://medic.madskill.ru/api/createProfile", method: .post, parameters: params, headers: headers)
            .responseString(){ resp in
                if resp.value != nil{
                    print(String(resp.value!))
                }
            }
    }
    
    func skip(){
        nav.currentScreen = "main"
    }
}
