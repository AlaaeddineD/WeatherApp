//
//  CityWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by WG CONSULTING on 14/05/2023.
//

import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "CityWeatherCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImageV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(city: City){
        nameLabel.text = city.name
        
        tempLabel.text = city.temperature != nil ? "\(Int(city.temperature!))°C" : "--"
        if city.icon != nil {
            iconImageV.image = UIImage(named: city.icon!)
        }
    }
}
