//
//  OnboadingVM.swift
//  Imedic
//
//  Created by Иван on 16.03.2023.
//

import Foundation

class OnboardingTDDVM: ObservableObject{
    
    @Published var nav: NavVm
    init(nav: NavVm){
        self.nav = nav
        
    }
    
    @Published var queue = [OnboardingItem?](repeating: nil, count: 3)
    
    @Published var buttonText = "Продолжить"
    
    func fillQueue(){
        
        queue.append(OnboardingItem(title: "Анализы", descr: "Экспресс сбор и получение проб", image: "onboard1"))
        queue.append(OnboardingItem(title: "Уведомления", descr: "Вы быстро узнаете о результатах", image: "onboard2"))
        queue.append(OnboardingItem(title: "Мониторинг", descr: "Наши врачи всегда наблюдают за вашими показателями здоровья", image: "onboard3"))
    }
    
    func nextBoard(){
        
    }
    
    func next(){
        
    }
}
