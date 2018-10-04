//
//  CountryListTableViewCell.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/4/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dialCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(_ countryDialCode: CountryDialCode) {
        nameLabel.text = "\(countryDialCode.name) (\(countryDialCode.name_code))"
        dialCodeLabel.text = countryDialCode.dial_code
    }
}
