//
//  AvatarTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var usernameProfile: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var postAvatar: UIImageView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var imagelibraryButton: UIButton!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var viewAvatar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.setRounded()
        postAvatar.setRounded()
        viewAvatar.setViewrounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func fillData(_ imagecover: UIImage, _ avatarimage: UIImage,_ profilename: String,_ postavatar: UIImage) {
        coverImage.image = imagecover
        avatarImage.image = avatarimage
        usernameProfile.text = profilename
        postAvatar.image = postavatar
    }
    @IBAction func DescriptionButtonAction(_ sender: Any) {
    }
    
}
