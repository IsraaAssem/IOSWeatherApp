//
//  NetworkManager.swift
//  WeatherAppSwiftUI
//
//  Created by Israa Assem on 19/05/2024.
//

import Foundation
import CoreLocation

class NetworkManager{
   static func fetchWeatherData(for location: CLLocation,completionHandler:@escaping(WeatherResponse?)->Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=ee08a7d2e7b34c37bb1121125241905&q=\(location.coordinate.latitude),\(location.coordinate.longitude)&days=3&aqi=yes&alerts=no"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                DispatchQueue.main.async {
                  completionHandler(nil)
                }
                print("Network error: ",error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                
                DispatchQueue.main.async {
                    print(weatherResponse)
                  completionHandler(weatherResponse)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                  completionHandler(nil)
                }
               
            }
        }.resume()
    }
    
}
//https://api.weatherapi.com/v1/forecast.json?key=ee08a7d2e7b34c37bb1121125241905&q=31.,30.23&days=1&aqi=yes&alerts=no
//https://api.weatherapi.com/v1/forecast.json?key=ee08a7d2e7b34c37bb1121125241905&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no
