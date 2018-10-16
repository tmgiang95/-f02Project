//
//  Comment.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/15/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation
class Comment {
    var commentID: Double
    var uid: String
    var content: String
    
    init(uID: String, content: String) {
        self.commentID = Date().toMillis()
        self.uid = uID
        self.content = content
    }
    
    func toDict() -> [String: Any]{
        var commentDict = [String: Any]()
        commentDict["uid"] = self.uid
        commentDict["commentID"] = self.commentID
        commentDict["content"] = self.content
        return commentDict
    }
}
