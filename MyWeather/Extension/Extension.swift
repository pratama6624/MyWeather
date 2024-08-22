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

extension ResponseBody {
    static var mock: ResponseBody {
        return ResponseBody(
            latitude: 37.7749,
            longitude: -122.4194,
            timezone: "PST",
            currentConditions: ResponseBody.CurrentConditions(
                temp: 20.0,
                feelslike: 18.0,
                humidity: 60.0,
                windspeed: 5.0,
                visibility: 10.0,
                conditions: "Clear"
            ),
            address: "San Francisco, CA",
            description: "Clear sky",
            days: [ResponseBody.Day.mock]
        )
    }
}

extension ResponseBody.Day {
    static var mock: ResponseBody.Day {
        return ResponseBody.Day(
            datetime: "2024-08-21",
            datetimeEpoch: 1692624000,
            tempmax: 30.0,
            tempmin: 20.0,
            temp: 25.0,
            feelslikemax: 32.0,
            feelslikemin: 22.0,
            feelslike: 27.0,
            humidity: 60.0,
            windspeed: 5.0,
            visibility: 10.0,
            conditions: "Clear",
            hours: [
                ResponseBody.Day.Hour(
                    datetime: "2024-08-21T01:00:00",
                    datetimeEpoch: 1692627600,
                    temp: 22.0,
                    feelslike: 23.0,
                    humidity: 65.0,
                    windspeed: 3.0,
                    visibility: 10.0,
                    conditions: "Partly Cloudy",
                    uvindex: 3
                )
            ]
        )
    }
}
