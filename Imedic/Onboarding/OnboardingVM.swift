//
//  OnboardingVM.swift
//  Imedic
//
//  Created by Иван on 22.02.2023.
//

import Foundation

class OnboardingVM: ObservableObject{
    
    @Published var btnText = "Пропустить"
    @Published var currentPos = 0 {
        didSet{
            currentImage = images[currentPos]
            currentTitle = titles[currentPos]
            currentText = texts[currentPos]
            
            switchPoint()
            
            btnText = currentPos != 2 ? "Пропустить" : "Завершить"
        }
    }
    
    @Published var currentImage = "onboard1"
    @Published var currentTitle = "Анализы"
    @Published var currentText = "Экспресс сбор и получение проб"
    @Published var points = ["active_point", "nonactive_point", "nonactive_point"]
    
    var images = ["onboard1", "onboard2", "onboard3"]
    var titles = ["Анализы", "Уведомления", "Мониторинг"]
    var texts = ["Экспресс сбор и получение проб", "Вы быстро узнаете о результатах", "Наши врачи всегда наблюдают за вашими показателями здоровья"]
    
    func incrementPos(){
        if currentPos < 2{
            currentPos += 1
        }
    }
    
    func decrementPos(){
        if currentPos > 0{
            currentPos -= 1
        }
    }

    func switchPoint(){
        
        switch currentPos{
        case 0:
            points[0] = "active_point"
            points[1] = "nonactive_point"
            points[2] = "nonactive_point"
            break
        case 1:
            points[0] = "nonactive_point"
            points[1] = "active_point"
            points[2] = "nonactive_point"
            break
        case 2:
            points[0] = "nonactive_point"
            points[1] = "nonactive_point"
            points[2] = "active_point"
            break
        default:
            points[0] = "active_point"
            points[1] = "nonactive_point"
            points[2] = "nonactive_point"
            break
        }
    }
    
}
