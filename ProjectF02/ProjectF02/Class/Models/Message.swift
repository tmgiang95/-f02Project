//
//  Messages.swift
//  ProjectF02
//
//  Created by admin on 9/23/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

final class Message {
    
    var content: String = ""
    var isNew : Int = 0
    var status : Int = 0
    var time : Int64 = 0
    var uID : String = ""
    
    init(content: String , isNew : Int , status : Int , time : Int64 , uID : String) {
        self.content = content
        self.isNew = isNew
        self.status = status
        self.time = time
        self.uID = uID
    }
    
    init(dict: [String: Any]) {
        if let content = dict["content"] as? String {
            self.content = content
        }
        if let isNew = dict["isNew"] as? Int {
            self.isNew = isNew
        }
        if let status = dict["status"] as? Int {
            self.status = status
        }
        if let time = dict["time"] as? Int64 {
            self.time = time
        }
        if let uID = dict["uID"] as? String {
            self.uID = uID
        }
    }
    
    func toDict() -> [String: Any]{
        var messDict = [String: Any]()
        messDict["content"] = self.content
        messDict["isNew"] = self.isNew
        messDict["status"] = self.status
        messDict["time"] = self.time
        messDict["uID"] = self.uID
        
        return messDict
    }
}
