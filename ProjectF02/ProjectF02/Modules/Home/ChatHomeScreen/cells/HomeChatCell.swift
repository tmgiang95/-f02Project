//
//  HomeChatCell.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/23/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class HomeChatCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var newestMessageContent: UILabel!
    var chat: Chat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func fillData(_ chat: Chat) {
        newestMessageContent.text = chat.messages.last?.content
        self.chat = chat
    }
    
}
