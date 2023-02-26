//
//  Register_Auth_Model.swift
//  Imedic
//
//  Created by Иван on 26.02.2023.
//

import Foundation

struct SendCodeInput: Encodable{
    var email: String
}

struct SendCodeOutput: Codable{
    
    var message: String
}
