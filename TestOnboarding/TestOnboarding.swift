//
//  TestOnboarding.swift
//  TestOnboarding
//
//  Created by Иван on 16.03.2023.
//

import XCTest
@testable import Imedic
import SDWebImage

final class TestOnboarding: XCTestCase {

    var onb = OnboardingTDDVM(nav: NavVm())

    func testSomeItemsInQueue(){
        
        XCTAssertEqual(onb.buttonText, "Продолжить")
    }
    
    func testBtnText(){
        onb.nextBoard()
        onb.nextBoard()
        
        XCTAssertEqual(onb.buttonText, "Завершить")
    }
    
    
    func testRetreivingFirst(){
        
        let resultOfCompare = compareItems(onb.queue.first, OnboardingItem(title: "Анализы", descr: "Экспресс сбор и получение проб", image: "onboard1"))
        XCTAssertTrue(resultOfCompare)
    }
    
    
    func testRetreivingSecond(){
    
        onb.nextBoard()
        
        var resultOfCompare = compareItems(onb.queue.first, OnboardingItem(title: "Уведомления", descr: "Вы быстро узнаете о результатах", image: "onboard2"))
        
        XCTAssertTrue(resultOfCompare)
    }
    
    
    func testRetreivingThird(){
        
        onb.nextBoard()
        onb.nextBoard()
        
        let resultOfCompare = compareItems(onb.queue.first, OnboardingItem(title: "Мониторинг", descr: "Наши врачи всегда наблюдают за вашими показателями здоровья", image: "onboard3"))
        XCTAssertTrue(resultOfCompare)
    }
    
    
    func testRetreiveAndDecrementingCount(){
        onb.nextBoard()
        XCTAssertTrue(onb.queue.count == 2)
    }
    
    
    
    func compareItems(_ first: OnboardingItem?, _ second: OnboardingItem) -> Bool{
        
        if first == nil{
            return false
        }
        
        if first!.image == second.image && first!.title == second.title && first!.descr == second.descr{
            return true
        }
        else{
            return false
        }
    }
}
