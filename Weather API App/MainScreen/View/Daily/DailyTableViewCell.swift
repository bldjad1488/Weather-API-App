//
//  DailyTableViewCell.swift
//  DailyTableViewCell
//
//  Created by Polina Prokopenko on 09.08.2021.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    // MARK: Убрать avakeFromNib и setSelected, если не пригодится
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "DailyTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
}
