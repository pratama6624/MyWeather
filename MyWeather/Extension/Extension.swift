//
//  Extension.swift
//  MyWeather
//
//  Created by Pratama One on 15/08/24.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
    
    func toCelciul() -> Double {
        return (self - 32) * 5 / 9
    }
}
