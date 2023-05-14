//
//  WeatherApiCall.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import Foundation

final class WeatherApiCall{
    
    func makeWeatherApiCall(city: City) async -> Result<City,ApiCallError>{
        
        guard let url = URL(string: WeatherApi.weatherDetailsUrl(latitude: city.latitude, longitude: city.longitude)) else {
            return .failure(.url_not_found)
        }
        
        let request = URLRequest(url: url)
        
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            
            let weatherData: CityWeatherData = try JSONDecoder().decode(CityWeatherData.self, from: data)
            
            let cityData = City(name: city.name,
                                latitude: city.latitude,
                                longitude: city.longitude,
                                temperature: weatherData.getTemp(),
                                icon: weatherData.getIconName())
            
            print("\(cityData.name)  \(cityData.temperature)")
            
            return .success(cityData)
        }catch{
            print("Fetch weather data attempt for \(city.name) failed with error: \(error.localizedDescription)")
            return .failure(.unexpected_error)
        }
    }
    
}

enum ApiCallError: Error{
    case url_not_found
    case unexpected_error
}
