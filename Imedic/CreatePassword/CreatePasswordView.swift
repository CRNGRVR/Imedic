//
//  CreatePasswordView.swift
//  Imedic
//
//  Created by Иван on 24.02.2023.
//

import SwiftUI

struct CreatePasswordView: View {
    
    @ObservedObject var createPasswordVM: CreatePasswordVM
    init(nav: NavVm){
        createPasswordVM = CreatePasswordVM(nav: nav)
    }
    
    var body: some View {
        
        VStack{
            HStack{
                
                Spacer()
                
                Button(action: {createPasswordVM.skip()}, label: {
                    Text("Пропустить")
                        .font(.system(size: 15))
                })
                .padding(.trailing, 20)
                
            }
            
            Spacer()
            
            Text("Создайте пароль")
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 16)
            
            Text("Для защиты ваших персональных данных")
                .font(.system(size: 15))
                .foregroundColor(Color.gray)
                
            Spacer()
            
            
            passPoints(points: createPasswordVM.pass_points)
                .padding(.bottom, 60)
            
            keyboard(vm: createPasswordVM)
            
            Spacer()
        }
    }
}



struct passPoints: View{
    
    var points: [Bool]
    
    var body: some View{
        
        HStack{
            Image(points[0] ? "active_pass_point" : "nonactive_pass_point")
            Image(points[1] ? "active_pass_point" : "nonactive_pass_point")
            Image(points[2] ? "active_pass_point" : "nonactive_pass_point")
            Image(points[3] ? "active_pass_point" : "nonactive_pass_point")
        }
    }
}


struct key: View{
    
    @ObservedObject var vm: CreatePasswordVM
    var key: Int
    
    var body: some View{
        
        Button(action: {vm.numKeyPressed(key: self.key)}, label: {
            ZStack{
                Color("tf")
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Text(String(key))
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Color.black)
                    
            }
        })
    }
}

struct keyboard: View{
    
    @ObservedObject var vm: CreatePasswordVM
    
    var body: some View{
        VStack(spacing: 24){
            HStack(spacing: 24){
                key(vm: vm, key: 1)
                key(vm: vm, key: 2)
                key(vm: vm, key: 3)
            }
            HStack(spacing: 24){
                key(vm: vm, key: 4)
                key(vm: vm, key: 5)
                key(vm: vm, key: 6)
            }
            HStack(spacing: 24){
                key(vm: vm, key: 7)
                key(vm: vm, key: 8)
                key(vm: vm, key: 9)
            }
            HStack(spacing: 24){
                key(vm: vm, key: 0)
                    .padding(.leading, 80)
                
                Button(action: {
                    vm.numKeyPressed(key: -1)
                }, label: {
                    Image("DEL")
                })
                .padding(.leading, 20)
            }
        }
    }
}

struct prewiew3: PreviewProvider{
    
    static var previews: some View{
        CreatePasswordView(nav: NavVm())
    }
}
