//
//  ЩквукМЬ.swift
//  Imedic
//
//  Created by Иван on 13.03.2023.
//

import Foundation

class OrderVM: ObservableObject{
    
    @Published var anVM: AnCartVM
    
    init(anVM: AnCartVM) {
        self.anVM = anVM
    }
    
}
