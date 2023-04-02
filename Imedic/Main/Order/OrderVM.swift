//
//  ЩквукМЬ.swift
//  Imedic
//
//  Created by Иван on 13.03.2023.
//

import Foundation
import CoreLocation

class OrderVM: ObservableObject{
    
    @Published var anVM: AnCartVM
    
    init(anVM: AnCartVM) {
        self.anVM = anVM
    }
    
    @Published var lat = ""
    @Published var lon = ""
    
    
    let locationManager = CLLocationManager()
    
    
    func request(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getl(){
        print(locationManager.location?.coordinate.latitude)
        print(locationManager.location?.coordinate.longitude)
    }
}
