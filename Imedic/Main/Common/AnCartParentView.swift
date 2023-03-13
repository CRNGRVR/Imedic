//
//  AnCartParentView.swift
//  Imedic
//
//  Created by Иван on 03.03.2023.
//

import SwiftUI

struct AnCartParentView: View {
    
    @ObservedObject var anCartVM: AnCartVM
    init(nav: NavVm){
        anCartVM = AnCartVM(nav: nav)
    }
    
    var body: some View {
        switch anCartVM.anCartNav{
        case "list":
            AnView(anCartVM: anCartVM)
            
        case "cart":
            CartView(anCartVM: anCartVM)
        case "preloader":
            PreloaderView()
            
        default:
            AnView(anCartVM: anCartVM)
        }
    }
    
}
//struct AnCartParentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnCartParentView()
//    }
//}
