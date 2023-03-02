//
//  MainModel.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation

//   Структура возвращаемых данных из api
struct NewsOutputUnit: Codable, Identifiable{
    var id: Int
    var name: String
    var description: String
    var price: String
    var image: String
}

//   Структура возвращаемых данных из api
struct CatalogOutputUnit: Codable, Identifiable{
    var id: Int
    var name: String
    var description: String
    var price: String
    var category: String
    var time_result: String
    var preparation: String
    var bio: String
}


struct Category: Identifiable{
    var id: Int
    var name: String
    var isActive: Bool = false
}


//  Для объектов каталога и работы с ними
struct CatalogItem: Identifiable{
    
    //  Приходязие с сервера значения
    var id: Int
    var name: String
    var description: String
    var price: String
    var category: String
    var time_result: String
    var preparation: String
    var bio: String
    
    //  Дополнительные, для удобства работы
    var isInCart: Bool
    var count: Int
}
