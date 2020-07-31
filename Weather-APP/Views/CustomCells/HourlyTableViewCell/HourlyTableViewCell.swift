//
//  HourlyTableViewCell.swift
//  Weather-APP
//
//  Created by kasper on 7/29/20.
//  Copyright © 2020 Mahmoud.Abdul-Wahab.Weather-APP. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    //var hours = [HoureWeather]()
    var hours : [HoureWeather]?{
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet var collectionView : UICollectionView!
    static let identifier = "HourlyTableViewCell"
    
    static func nib()-> UINib
    {
        return UINib(nibName : "HourlyTableViewCell" , bundle : nil)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension HourlyTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.houreWeater = hours![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
