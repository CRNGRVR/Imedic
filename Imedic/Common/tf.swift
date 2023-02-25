//
//  tf.swift
//  Imedic
//
//  Created by Иван on 25.02.2023.
//

import SwiftUI

struct tf: View{
    
    @Binding var text: String
    var placeHolder: String
    
    var body: some View{
        
        ZStack{
            RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)
            
            TextField(placeHolder, text: $text)
                .padding(.leading, 15)
        }
        .frame(width: 335, height: 48)
        .background(Color("tf"))

    }
}
