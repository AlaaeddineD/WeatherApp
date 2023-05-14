//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation

final class WeatherApi{
    private static let baseUrl = "https://api.openweathermap.org/"
    private static let apiKey = "3a72eaf64f3c7fd81cdb020612e44420"
    
    static func weatherDetailsUrl(latitude: Double, longitude: Double) -> String{
        return "\(baseUrl)data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
    }
}
