//
//  WeatherViewModel.swift
//  Weather-APP
//
//  Created by kasper on 7/31/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit
class WeatherViewModel {
    
    var weather : WeatherResponse?
    
    var dailyWeather : [DayWeather]? {
        return weather?.daily
    }
    var hourWeather : [HoureWeather]?{
        return weather?.hourly
    }
    
    typealias getWeatherApi = (_ status : Bool , _ message : String)->Void
    var weatherCallBack : getWeatherApi?
    
    func requestWeatherForLocation(long : Double , lat : Double )  {
        
        let ureString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely&appid=a43c524437016983d9ebc51a1b12f8cd"
        let url =  URL(string : ureString )
        //  print(ureString)
        guard  let URL = url  else{
            self.weatherCallBack?(false , " unable to unwrape URL")
            return
            
        }
        URLSession.shared.dataTask(with: URL) { [weak self] (data, response, error) in
            guard let self = self else{return}
            guard let data = data , error == nil  else{
                self.weatherCallBack?(false , "there is no Received Data")
                
                return
                
            }
            
            var jsonData : WeatherResponse?
            
            do{
                jsonData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print(jsonData!)
                guard let json = jsonData else {return}
                //print(json.timezone )
                print(json.daily[0].temp)
                
                self.weather = json
                
                self.weatherCallBack?(true , "Operation Done successfuly ")
                
                
            }
            catch{
                self.weatherCallBack?(false , " unable to Decode the Model")
                
                print("Error \(error)")
            }
            
        }.resume()
        
    }
    
    
    // take a closure as a parameter
    func weatherCompletionHandler(callBack : @escaping getWeatherApi) {
        
        self.weatherCallBack = callBack
    }
    
}
