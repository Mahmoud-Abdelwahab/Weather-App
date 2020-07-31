//
//  ViewController.swift
//  Weather-APP
//
//  Created by kasper on 7/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit
import CoreLocation


//MARK:- CoreLocation
// tableview
// collectionView with custom cell
// weather api

class MainVC: UIViewController {
    
    var  weatherViewModel = WeatherViewModel()
    
    var weather : WeatherResponse?
    var dailyWeather = [DayWeather]()
    var hourWeather  = [HoureWeather]()
    // Mock location
    var currentLocation : CLLocation?
    let locationManger = CLLocationManager()
    
    @IBOutlet var table : UITableView!
    var models = [Weather]()
    
    lazy var tableHeader : UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.height/3))
        header.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTable()
        
        // configurTableHeaderContent()
        weatherViewModel.weatherCompletionHandler { [weak self](status, message) in
            guard let self = self else{return}
            if status {
                DispatchQueue.main.async {
                    
                    self.weather = self.weatherViewModel.weather
                    self.hourWeather = self.weatherViewModel.hourWeather!
                    self.dailyWeather = self.weatherViewModel.dailyWeather!
                    self.configurTableHeaderContent()
                    self.table.reloadData()
                }
                
                
            }else{
                print(message)
            }
        }
        
        
        
    }
    
    
    func configurTableHeaderContent(){
        let locationLable = UILabel(frame: CGRect(x: 10, y: 15, width: view.frame.size.width - 20 , height: view.frame.size.height / 7))
        tableHeader .addSubview(locationLable)
        locationLable.text = "Current Weather" // create Tuple insted of this object and add all the values in it
        locationLable.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        locationLable.textAlignment = .center
        let summaryLable  = UILabel(frame: CGRect(x: 10, y:  locationLable.frame.size.height/2, width: view.frame.size.width - 20 , height: view.frame.size.height / 5))
        tableHeader .addSubview(summaryLable)
        
        guard  let weather = weather else {
            return
        }
        
        summaryLable.text = weather.timezone
        summaryLable.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        summaryLable.textAlignment = .center
        let tempLable     = UILabel(frame: CGRect(x: 10, y: locationLable.frame.size.height/3 + summaryLable.frame.size.height/3, width: view.frame.size.width - 20 , height: view.frame.size.height / 4))
        tempLable.text = "\(weather.current.temp)°"
        tempLable.font =  UIFont(name: "Helvetica-Bold", size: 35)
        tempLable.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tempLable.textAlignment = .center
        tableHeader .addSubview(tempLable)
        
    }
    
    func configureTable(){
        /// register two cells
        table.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        view.backgroundColor  = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        table.tableHeaderView = tableHeader
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        
        table.dataSource = self
        table.delegate   = self
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setUpLocation()
    }
    
    // setup location
    
    func setUpLocation() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
}

extension MainVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // for the collectionView cell
        }else{
            return dailyWeather.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = table.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            
            cell.hours = hourWeather
            return cell
        }else{
            let cell = table.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            
            cell.dayWeather = dailyWeather[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    // add new section in tableView for the horizontal tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

extension MainVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty , currentLocation == nil{
            currentLocation = locations.first
            locationManger.stopUpdatingLocation() //** this is important to save your battary life
            requestWeatherForLocation()//
            
            
        }
    }
    
    func requestWeatherForLocation()  {
        guard let currentLocation = currentLocation else {
            return
        }
        // 31.202926 ,29.9008892
        let long = currentLocation.coordinate.longitude
        // let long = 29.9008892
        let lat = currentLocation.coordinate.latitude
        weatherViewModel.requestWeatherForLocation(long: long, lat: lat)
        
        
    }
}
