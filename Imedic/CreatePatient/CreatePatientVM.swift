//
//  CreatePatientVM.swift
//  Imedic
//
//  Created by Иван on 26.02.2023.
//

import Foundation

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
}
