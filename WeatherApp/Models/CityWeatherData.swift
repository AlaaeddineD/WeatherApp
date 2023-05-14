//
//  CityWeatherData.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation

struct CityWeatherData: Decodable{
    let weather: [Weather]
    let main: Main
    
    func getTemp() -> Double{
        return main.temp
    }
    
    func getIconName() -> String? {
        if weather.count == 0{
            return nil
        }
        return weather[0].icon
    }
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let main, description, icon: String
}
