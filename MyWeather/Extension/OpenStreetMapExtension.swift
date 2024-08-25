//
//  OpenStreetMapExtension.swift
//  MyWeather
//
//  Created by Pratama One on 17/08/24.
//

import Foundation
import CoreLocation

// Open street map is an API that provides worldwide address data that can also be accessed for free
extension CLLocationCoordinate2D {
    func getCityNameFromNominatim() async throws -> String? {
        let urlString = "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=\(self.latitude)&lon=\(self.longitude)&zoom=18&addressdetails=1"
        guard let url = URL(string: urlString) else { fatalError("Location not found") }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        let decoder = JSONDecoder()
        let geocodingResponse = try decoder.decode(NominatimResponse.self, from: data)
        
        if let cityDistrict = geocodingResponse.address.city_district {
            return cityDistrict
        }
        
        return geocodingResponse.address.city
    }
}

struct NominatimResponse: Decodable {
    let address: Address
    
    struct Address: Decodable {
        let city_district: String?
        let city: String?
        let town: String?
        let village: String?
    }
}
