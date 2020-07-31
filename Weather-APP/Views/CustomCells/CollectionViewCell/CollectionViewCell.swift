//
//  CollectionViewCell.swift
//  Weather-APP
//
//  Created by kasper on 7/31/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var houreWeater : HoureWeather?{
        didSet{
            setUpCell()
        }
    }
    func  setUpCell() {
        guard let houre = houreWeater else {
            print("no data")
            return
        }
        tempLable.text = "\(houre.temp)°"
        iconeImage.contentMode = .scaleAspectFit
        iconeImage.image = UIImage(named: houre.weather[0].icon)
        
    }
    @IBOutlet var iconeImage : UIImageView!
    @IBOutlet var tempLable  : UILabel!
    
    static let identifier = "CollectionViewCell"
    
    static func nib()-> UINib
    {
        return UINib(nibName : "CollectionViewCell" , bundle : nil)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
