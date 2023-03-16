//
//  PercentageFromScreen.swift
//  Imedic
//
//  Created by Иван on 15.03.2023.
//

import Foundation
import SwiftUI

struct PercentageFromScreen{
    
    static var shared = PercentageFromScreen()
    
    private var width = UIScreen.main.bounds.width
    private var height = UIScreen.main.bounds.height
    
    func h(_ percent: CGFloat) -> CGFloat{
        return (height / 100.0) * percent
    }
    
    func w(_ percent: CGFloat) -> CGFloat{
        return (width / 100.0) * percent
    }
}
