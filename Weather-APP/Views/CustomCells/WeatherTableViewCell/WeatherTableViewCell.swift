//
//  WeatherTableViewCell.swift
//  Weather-APP
//
//  Created by kasper on 7/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var dayLable  : UILabel!
    @IBOutlet var highTemp  : UILabel!
    @IBOutlet var lowTemp   : UILabel!
    @IBOutlet var iconImage : UIImageView!
    
    var dayWeather : DayWeather? {
        didSet{
            setUpWeatherCell()
        }
    }
    func setUpWeatherCell() {
        guard let day = dayWeather else {
            print("no data")
            return
        }
        highTemp.text = "\(Int(day.temp.max))°"
          lowTemp.text = "\(Int(day.temp.min))°"
        iconImage.image = UIImage(named: day.weather[0].icon)
        dayLable.text = getDayForDate(Date(timeIntervalSince1970: Double(day.dt)))
    }
    static let identifier = "WeatherTableViewCell"
    
    static func nib()-> UINib
    {
        return UINib(nibName : "WeatherTableViewCell" , bundle : nil)
        
    }
    
    
    func getDayForDate(_ date : Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // for days like firday
        return formatter.string(from: inputDate)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
