//
//  PreloaderView.swift
//  Imedic
//
//  Created by Иван on 12.03.2023.
//

import SwiftUI

struct PreloaderView: View {
    
    @ObservedObject var preloaderVM = PreloaderVM()
    
    var body: some View {
        VStack{
            Text("Оплата")
            
            Image("loading")
                .rotationEffect(.degrees(Double(preloaderVM.rotation)))
        }
        .onAppear{
            preloaderVM.rotating()
        }
    }
}

struct PreloaderView_Previews: PreviewProvider {
    static var previews: some View {
        PreloaderView()
    }
}
