//
//  CartPersistenceController.swift
//  Imedic
//
//  Created by Иван on 12.03.2023.
//

import Foundation
import CoreData

struct CartPersistenceController{
    
    var persistentContainer: NSPersistentContainer
    static let shared = CartPersistenceController()
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(){
        persistentContainer = NSPersistentContainer(name: "CartDataModel")
        persistentContainer.loadPersistentStores{_, err in
            if err != nil{
                fatalError("CD Failed.")
            }
        }
    }
}
