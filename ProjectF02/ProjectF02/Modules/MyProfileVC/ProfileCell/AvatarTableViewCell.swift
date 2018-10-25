//
//  AvatarTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var UserNameProfile: UILabel!
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var PostAvatar: UIImageView!
    @IBOutlet weak var DescriptionButton: UIButton!
    @IBOutlet weak var ImageLibraryButton: UIButton!
    @IBOutlet weak var FriendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AvatarImage.setRounded()
        PostAvatar.setRounded()
        configureButtonLogin(button: FriendButton)
        configureButtonLogin(button: DescriptionButton)
        configureButtonLogin(button: ImageLibraryButton)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureButtonLogin(button : UIButton) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: button.frame.size)
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: button.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        button.layer.addSublayer(gradient)
    }
    
    func fillData(_ imagecover: UIImage, _ avatarimage: UIImage,_ profilename: String,_ postavatar: UIImage) {
        CoverImage.image = imagecover
        AvatarImage.image = avatarimage
        UserNameProfile.text = profilename
        PostAvatar.image = postavatar
    }
    @IBAction func DescriptionButtonAction(_ sender: Any) {
    }
    
}
