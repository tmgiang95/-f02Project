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
    @IBOutlet weak var LikeButton: UIButton!
    @IBOutlet weak var CommentButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ImageAvatar.setRounded()
        ImageViewPost.setRounded()
            configureButtonLogin(button: LikeButton)
        configureButtonLogin(button: CommentButton)
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

