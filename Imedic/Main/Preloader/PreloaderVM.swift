//
//  PreloaderVM.swift
//  Imedic
//
//  Created by Иван on 12.03.2023.
//

import Foundation

class PreloaderVM: ObservableObject{
    
    @Published var rotation = 0
    
    func rotating(){
        
        print("in")
        
        DispatchQueue.global(qos: .default).async {
            
            print("in thread")
            
            for _ in 0...100000{
                
                print("tic")
                
                usleep(10000)
                self.rotation += 1
            }
        }
    }
}
