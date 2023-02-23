//
//  ContentView.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var navVm = NavVm()
    
    var body: some View {
        Onboarding(navVm: navVm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
