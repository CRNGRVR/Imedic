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
        fillQueue()
    }
    
    @Published var queue: [OnboardingItem] = []
    
    @Published var buttonText = "Продолжить"
    
    func fillQueue(){
        
        queue.append(OnboardingItem(title: "Анализы", descr: "Экспресс сбор и получение проб", image: "onboard1"))
        queue.append(OnboardingItem(title: "Уведомления", descr: "Вы быстро узнаете о результатах", image: "onboard2"))
        queue.append(OnboardingItem(title: "Мониторинг", descr: "Наши врачи всегда наблюдают за вашими показателями здоровья", image: "onboard3"))
    }
    
    func nextBoard(){
        
        if queue.count > 1{
            
            queue.remove(at: 0)
            
            if queue.count == 1{
                buttonText = "Завершить"
            }
        }
    }
    
    func next(){
        nav.currentScreen = "reg_auth"
        UserDefaults.standard.set(true, forKey: "isLoadedYet")
    }
}
