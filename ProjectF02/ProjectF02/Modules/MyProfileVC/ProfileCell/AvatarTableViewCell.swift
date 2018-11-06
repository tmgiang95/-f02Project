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
    @IBOutlet weak var viewWhatyouthink: UIView!
   

    var descriptionHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        avatarImage.setRounded()
        postAvatar.setRounded()
        viewAvatar.setViewrounded()
        viewWhatyouthink.layer.borderColor = UIColor.black.cgColor
        viewWhatyouthink.layer.borderWidth = 0.5
        postAvatar.layer.borderColor = UIColor.black.cgColor
        postAvatar.layer.borderWidth = 0.5
        
       
    }
    
    
    func fillData(_ user: User ) {
        coverImage.kf.setImage(with: URL(string: user.cover ?? ""))
        avatarImage.kf.setImage(with: URL(string: user.avatar ?? ""))
//        let firstname = user.firstName ?? ""
//        let lastname = user.lastName ?? ""
        usernameProfile.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
        postAvatar.kf.setImage(with: URL(string: user.avatar ?? ""))
    }
    
    @IBAction func descriptionButtonAction(_ sender: Any) {
        descriptionHandler?()
    }
    
}
