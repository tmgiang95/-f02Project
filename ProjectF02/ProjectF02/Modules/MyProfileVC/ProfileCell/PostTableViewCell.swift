//
//  PostTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseStorage
import Kingfisher
import FTPopOverMenu_Swift

final class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heighImageview: NSLayoutConstraint!
    @IBOutlet weak var viewButtonlikecomment: UIView!
    @IBOutlet weak var viewLikecomment: UIView!
    @IBOutlet weak var timePosted: UILabel!
    @IBOutlet weak var imageviewPost: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var likenumberLabel: UILabel!
    @IBOutlet weak var labeluserName: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var labelContentpost: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureView() {
        viewLikecomment.layer.borderColor = UIColor.black.cgColor
        viewLikecomment.layer.borderWidth = 0.5
         imageAvatar.setRounded()
    }
    
    func fillData(_ post: Post,_ useruid: String)
    {
        let postavatarref = Storage.storage().reference().child("avatar").child(useruid)
        postavatarref.downloadURL { (avatarurl, er) in
            if er != nil {
                print(er!)
            }
            else {
                let avatarstring = avatarurl?.absoluteString ?? ""
                self.imageAvatar.kf.setImage(with: URL(string: avatarstring))
            }
        }
        if post.imageLink == 1{
            imageviewPost.isUserInteractionEnabled = true
            imageviewPost.isHidden = false
            heighImageview.constant = 250
            let postimageref = Storage.storage().reference().child("post").child(useruid).child(post.postid ?? "")
            postimageref.downloadURL { (url, err) in
                if err != nil {
                    print(err!)
                }
                else {
                    let postimagestring = url?.absoluteString ?? ""
                    self.imageviewPost.kf.setImage(with: URL(string: postimagestring))
                }
            }
        }
        else {
           imageviewPost.isHidden = true
            heighImageview.constant = 1
            imageviewPost.isUserInteractionEnabled = false
        }
        labeluserName.text = post.fullName
        labelContentpost.text = post.contentText
        let defaulttimestamp: Double = Double()
        let date = Date(timeIntervalSince1970: post.time ?? defaulttimestamp )
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy "
        let strDate = dateFormatter.string(from: date)
        timePosted.text = strDate
        likenumberLabel.text = (String(post.like.count) + " lượt thích")
       
    }
    
    @IBAction func LikeButtonAction(_ sender: Any) {
    }
    
    @IBAction func CommentButtonAction(_ sender: Any) {
    }
    
    @IBAction func editPostaction(_ sender: Any) {
        let config = FTConfiguration.shared
        config.backgoundTintColor = UIColor.white
        config.borderColor = UIColor.lightGray
        config.menuWidth = 80
        config.menuSeparatorColor = UIColor.lightGray
        config.menuRowHeight = 40
        config.cornerRadius = 6
    }
    
    
}

