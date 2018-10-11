//
//  Post.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/11/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

class Post {
    var uID: String?
    var postID: String?
    var imageLink: String?
    var contentText: String?
    var like = [String]()
    var comment = [String]()
    var time: Double?
    
    
    init(_ dict: [String:Any]) {
        if let uid = dict["uID"] as? String{
            self.uID = uid
        }
        if let postID = dict["postID"] as? String {
            self.postID = postID
        }
        if let imageLink = dict["imageLink"] as? String {
            self.imageLink = imageLink
        }
        if let contentText = dict["contentText"] as? String {
            self.contentText = contentText
        }
        if let like = dict["like"] as? [String:Any] {
            self.like = like.values.map({ (value: Any) -> String? in
                return value as? String
            }).compactMap({$0})
        }
        if let comment = dict["comment"] as? [String:Any] {
            self.comment = comment.values.map({ (value: Any) -> String? in
                return value as? String
            }).compactMap({$0})
        }
        if let time = dict["time"] as? Double {
            self.time = time
        }
    }
}
