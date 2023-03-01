//
//  MainModel.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation

struct News: Codable{
    var news: [NewsOutputUnit]
}

struct NewsOutputUnit: Codable, Identifiable{
    var id: Int
    var name: String
    var description: String
    var price: String
    var image: String
}



struct Catalog: Codable{
    var catalogUnit: [CatalogOutputUnit]
}

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
