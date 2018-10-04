//
//  ChatTableViewCell1.swift
//  ProjectF02
//
//  Created by admin on 9/23/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class ChatTableViewCell1: UITableViewCell {
    @IBOutlet weak var messView: UIView!
    @IBOutlet weak var messLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configureUI() {
        messView.layer.cornerRadius = 10
        messView.clipsToBounds = true
    }
    
    func fillData(_ data: Message) {
        messLabel.text = data.content
    }
    
}
