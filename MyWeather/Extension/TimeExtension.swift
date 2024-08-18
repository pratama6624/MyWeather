//
//  TimeExtension.swift
//  MyWeather
//
//  Created by Pratama One on 18/08/24.
//

import Foundation

struct TimeExtension {
    func convertEpochToHour(epoch: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epoch)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    func convertEpochToDay(epoch: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epoch)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        return formatter.string(from: date)
    }
    
    func convertEpochToDayAndDate(epoch: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epoch)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd"
        
        return formatter.string(from: date)
    }
}
