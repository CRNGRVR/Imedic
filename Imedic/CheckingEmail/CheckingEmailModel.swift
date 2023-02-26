//
//  CheckingEmailModel.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import Foundation

struct CheckingEmailInput: Encodable{
    var email: String
    var code: String
}

struct CheckingEmailOutput: Codable{
    var token: String
}
