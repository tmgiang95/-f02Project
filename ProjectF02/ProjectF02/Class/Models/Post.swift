//
//  Post.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/11/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

class Post {

    var fullName: String?
    var uid: String?
    var postid: String?
    var imageLink: Int?
    var contentText: String?
    var like = [String]()
    var comment = [Comment]()
    var time: Double?
    
    init() {
    }
    
    init(_ dict: [String:Any]) {
        if let fullName = dict["fullName"] as? String{
            self.fullName = fullName
        }
        if let uid = dict["uid"] as? String {
            self.uid = uid
        }
        if let postid = dict["postid"] as? String {
            self.postid = postid
        }
        if let imageLink = dict["imageLink"] as? Int {
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
            self.comment = comment.values.map({ (value: Any) -> Comment? in
                return value as? Comment
            }).compactMap({$0})
        }
        if let time = dict["time"] as? Double {
            self.time = time
        }
    }
    
    func toDict() -> [String: Any]{
        var postDict = [String: Any]()
        postDict["fullName"] = self.fullName
        postDict["uid"] = self.uid
        postDict["postid"] = self.postid
        postDict["imageLink"] = self.imageLink
        postDict["contentText"] = self.contentText
        
        var commentListToDict = [[String: Any]]()
        comment.forEach { (value) in
            commentListToDict.append(value.toDict())
        }
        var likeListToDict = [String: Any]()
        var id = 0
        like.forEach { (value) in
            likeListToDict["\(id)"] = value
            id += 1
        }
        postDict["like"] = likeListToDict
        postDict["comment"] = commentListToDict
        postDict["time"] = self.time
        
        return postDict
    }
    
}
