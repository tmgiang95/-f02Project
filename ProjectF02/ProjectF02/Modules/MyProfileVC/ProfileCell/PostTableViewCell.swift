//
//  PostTableViewCell.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
   
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
        imageAvatar.setRounded()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func fillData(_ imageAvt: UIImage, _ username: String, _ post: Post)
    {
        imageAvatar.image = imageAvt
        labeluserName.text = username
        labelContentpost.text = post.contentText
    }
    
    @IBAction func LikeButtonAction(_ sender: Any) {
    }
    
    @IBAction func CommentButtonAction(_ sender: Any) {
    }
}

