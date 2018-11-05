//
//  PostTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import Kingfisher

final class PostTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var viewButtonlikecomment: UIView!
    @IBOutlet weak var viewLikecomment: UIView!
    @IBOutlet weak var timePosted: UILabel!
    @IBOutlet weak var imageviewPost: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
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
        viewLikecomment.layer.cornerRadius = 5
         imageAvatar.setRounded()
        viewButtonlikecomment.layer.borderColor = UIColor.black.cgColor
        viewButtonlikecomment.layer.borderWidth = 0.1
        viewButtonlikecomment.layer.cornerRadius = 5
    }
    
    func fillData(_ post: Post)
    {
        if post.imageLink == nil {
//            imageviewPost.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            imageviewPost.removeFromSuperview()
        } else {
            imageviewPost.kf.setImage(with: URL(string: post.imageLink ?? ""))
        }
        imageAvatar.kf.setImage(with: URL(string: post.avatar ?? ""))
        labeluserName.text = post.fullName
        labelContentpost.text = post.contentText
    }
    
    @IBAction func LikeButtonAction(_ sender: Any) {
    }
    
    @IBAction func CommentButtonAction(_ sender: Any) {
    }
}

