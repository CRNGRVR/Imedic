//
//  ResView.swift
//  Imedic
//
//  Created by Иван on 05.03.2023.
//

import SwiftUI

struct ResView: View {
    var body: some View {
        Image("zagl")
            .resizable()
            .frame(width: 200, height: 200)
    }
}

struct ResView_Previews: PreviewProvider {
    static var previews: some View {
        ResView()
    }
}
