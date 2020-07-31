//
//  Weather.swift
//  Weather-APP
//
//  Created by kasper on 7/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit

struct  WeatherResponse : Codable {
    let lat : Double
    let lon : Double  // must be Double not String
    let timezone: String
    
    var current : CurrentWeather
    var hourly  : [HoureWeather]
    var daily   : [DayWeather]
    
}



struct CurrentWeather : Codable {
    
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point:Double
    let uvi: Double
    let clouds: Int
    let visibility:Int
    let wind_speed:Double
    let wind_deg: Int
    let weather: [Weather]
}
struct DayWeather : Codable {
    
    let dt:Int
    let sunrise: Int
    let sunset: Int
    
    let pressure: Int
    let humidity: Int
    
    let weather:[Weather]
    let temp : Temperature
    
}

struct HoureWeather : Codable {
    let temp : Double
    let weather : [Weather]
}

struct Weather : Codable {
    var id: Int
    var main:String
    var description: String
    var icon: String
    
}

struct Temperature : Codable {
    let day , min , max , night , eve , morn : Double
}
