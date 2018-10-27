//
//  Post.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/11/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

class Post {
    var uid: String?
    var postid: String?
    var imageLink: String?
    var contentText: String?
    var like = [String]()
    var comment = [Comment]()
    var time: Double?
    
    init() {
//        self.uid = "dNZVhNcTHaS8jhbRDt6UZBtOQ443"
//        self.postid = "postID2"
//        self.contentText = "day la cai stt thu 1"
//        self.like.append("NKuA2ohRSRN7CmCl0RQ1DIQagpE2")
//        self.like.append("dNZVhNcTHaS8jhbRDt6UZBtOQ443")
//        self.comment.append(Comment(uID: "dNZVhNcTHaS8jhbRDt6UZBtOQ443", content: "xam lz qua ban oi"))
//        self.comment.append(Comment(uID: "NKuA2ohRSRN7CmCl0RQ1DIQagpE2", content: "cut me may ngay"))
//        self.time = 1539612082
    }
    
    init(_ dict: [String: Any]) {
        if let uid = dict["uid"] as? String{
            self.uid = uid
        }
        if let postid = dict["postid"] as? String {
            self.postid = postid
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
