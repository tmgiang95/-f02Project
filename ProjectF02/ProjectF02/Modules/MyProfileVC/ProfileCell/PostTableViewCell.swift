//
//  PostTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TextfieldPost: UITextField!
    @IBOutlet weak var TimePost: UILabel!
    @IBOutlet weak var ImageViewPost: UIImageView!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var ImageAvatar: UIImageView!
    @IBOutlet weak var LikeNumberLabel: UILabel!
    @IBOutlet weak var LabelUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func fillData(_ imageAvt: UIImage,_ username: String)
    {
        ImageAvatar.image = imageAvt
        LabelUserName.text = username
    }
    
    @IBAction func LikeButtonAction(_ sender: Any) {
    }
    
    @IBAction func CommentButtonAction(_ sender: Any) {
    }
}

