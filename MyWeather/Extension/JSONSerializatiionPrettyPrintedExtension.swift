//
//  JSONSerializatiionPrettyPrinted.swift
//  MyWeather
//
//  Created by Pratama One on 18/08/24.
//

import Foundation

extension JSONSerialization {
    static func prettyString(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            let prettyJSONData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            if let prettyJSONString = String(data: prettyJSONData, encoding: .utf8) {
                print(prettyJSONString)
            }
        } catch {
            print("DEBUG: \(error)")
        }
    }
}
