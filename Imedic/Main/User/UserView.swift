//
//  UserView.swift
//  Imedic
//
//  Created by Иван on 27.02.2023.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var userVM = UserVM()
    
    var body: some View {
        Text("User")
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
