//
//  ChatTableViewCell1.swift
//  ProjectF02
//
//  Created by admin on 9/23/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class ChatTableViewCell1: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messView: UIView!
    @IBOutlet weak var messLabel: UILabel!
    @IBOutlet weak var messTime: UILabel!
    @IBOutlet weak var messViewTop: NSLayoutConstraint!
    @IBOutlet weak var avatarTop: NSLayoutConstraint!
    
    
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
        messView.layer.cornerRadius = 20
        messView.layer.borderWidth = 1
        messView.layer.borderColor = UIColor.lightGray.cgColor
        messView.clipsToBounds = true
    
    }
    
    func fillData(_ data: Message ,_ time : String) {
        messLabel.text = data.content
        messTime.text = time == "" ? "" : time
        messTime.isHidden = time == ""
        messViewTop.constant = time == "" ? 0 : 48
        avatarTop.constant = time == "" ? 0 : 48
        layoutIfNeeded()
        
    }
    
    
}
