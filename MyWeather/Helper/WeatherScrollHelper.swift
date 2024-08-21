//
//  WeatherScrollHelper.swift
//  MyWeather
//
//  Created by Pratama One on 18/08/24.
//

import Foundation
import SwiftUI

struct WeatherScrollHelper {
    static var currentEpochTime = Date().timeIntervalSince1970
    
    static func scrollToCurrentHour(proxy: ScrollViewProxy, weather: ResponseBody, currentEpochTime: TimeInterval) {
        if let firstDay = weather.days.first {
            if let currentHour = firstDay.hours.first(where: { $0.datetimeEpoch >= currentEpochTime }) {
                proxy.scrollTo(currentHour.datetimeEpoch, anchor: .leading)
            } else {
                if let lastHour = firstDay.hours.last {
                    print("Waktu sekarang: \(currentEpochTime)")
                    print("Waktu di app: \(lastHour.datetimeEpoch)")
                    proxy.scrollTo(lastHour.datetimeEpoch, anchor: .leading)
                }
            }
        }
    }
}
