//
//  AvatarTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseStorage
final class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var viewUpstatus: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var usernameProfile: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var postAvatar: UIImageView!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var imagelibraryButton: UIButton!
    @IBOutlet weak var viewAvatar: UIView!
    @IBOutlet weak var viewWhatyouthink: UIView!
    @IBOutlet weak var addFriendStackView: UIStackView!
    @IBOutlet weak var editAvatarView: UIView!
    enum ImageType {
        case avatar, cover
    }
    
    var descriptionHandler: (() -> Void)?
    var editcoverAction: (() -> Void)?
    var editavatarAction: (() -> Void)?
    var upstatusAction: (() -> Void)?
    var getalbumAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addFriendStackView.isHidden = true
        configureView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        avatarImage.setRounded()
        editAvatarView.setViewrounded()
        viewAvatar.setViewrounded()
        postAvatar.layer.borderColor = UIColor.black.cgColor
        postAvatar.layer.borderWidth = 0.5
        
    }
    
    
    func fillData(_ user: User ) {
        let coverref = Storage.storage().reference().child("cover").child(user.uid ?? "")
        coverref.downloadURL { (coverurl, error) in
            if error != nil {
                print(error!)
            }
            else {
                let coverstring = coverurl?.absoluteString ?? ""
                self.coverImage.kf.setImage(with: URL(string: coverstring))
            }
        }
        
        let avatarref = Storage.storage().reference().child("avatar").child(user.uid ?? "")
        avatarref.downloadURL { (avatarurl, er) in
            if er != nil {
                print(er!)
            }
            else {
                let avatarstring = avatarurl?.absoluteString ?? ""
                self.avatarImage.kf.setImage(with: URL(string: avatarstring))
                self.postAvatar.kf.setImage(with: URL(string: avatarstring))
            }
        }
        usernameProfile.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
    }
    
    @IBAction func descriptionButtonAction(_ sender: Any) {
        descriptionHandler?()
    }
  
    @IBAction func editAvataraction(_ sender: Any) {
    editavatarAction?()
    }
    
    @IBAction func editCoveraction(_ sender: Any) {
        editcoverAction?()
    }
    
    @IBAction func buttonUpstatus(_ sender: Any) {
    upstatusAction?()
    }
    
    @IBAction func getAlbumimageaction(_ sender: Any) {
     getalbumAction?()
    }
}
