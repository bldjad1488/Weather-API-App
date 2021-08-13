//
//  DailyTableViewCell.swift
//  DailyTableViewCell
//
//  Created by Polina Prokopenko on 09.08.2021.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "DailyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
    func configure(with model: DailyWeather) {
        
        dayLabel.text = formatDate(unixDate: model.dt)
        minTempLabel.text = "\(Int(model.temp.min))°"
        maxTempLabel.text = "\(Int(model.temp.max))°"
        
        dayLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        minTempLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        maxTempLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        
        // Weather image setting
        
        let condition = model.weather[0].description
        
        if condition.contains("rain") {
            iconImageView.image = UIImage(named: "rain")
        } else if condition.contains("clear") {
            iconImageView.image = UIImage(named: "clear")
        } else if condition.contains("clouds") {
            iconImageView.image = UIImage(named: "clouds")
        } else if condition.contains("drizzle") {
            iconImageView.image = UIImage(named: "rain")
        } else if condition.contains("thunderstorm") {
            iconImageView.image = UIImage(named: "thunderstorm")
        } else if condition.contains("snow") {
            iconImageView.image = UIImage(named: "snow")
        } else {
            iconImageView.image = UIImage(named: "rain")
        }
        
    }
    
    func formatDate(unixDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixDate))
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, EEE"
        
        return formatter.string(from: date)
    }
    
}
