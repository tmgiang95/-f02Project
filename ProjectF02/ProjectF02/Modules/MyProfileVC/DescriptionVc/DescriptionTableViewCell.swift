//
//  DescriptionTableViewCell.swift
//  ProjectF02
//
//  Created by mac one on 11/5/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var labelKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func fillData (_ user: User)
    {
        
    }
    
}
