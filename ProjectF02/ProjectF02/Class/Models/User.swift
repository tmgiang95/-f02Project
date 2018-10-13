//
//  User.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/18/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

class User {
    var uID: String? = ""
    var firstName: String? = ""
    var lastName: String? = ""
    var birthday: Double? = 0.0
    var gender: Bool = true
    var avatar: String? = ""
    var cover: String? = ""
    var description: String? = ""
    var friendList = [String: Any]()
    var isAvailable: Bool = false
    var phone: String = ""
    
    init(_ dict: [String:Any]) {
        if let uid = dict["uid"] as? String{
            self.uID = uid
        }
        if let firstName = dict["firstName"] as? String {
            self.firstName = firstName
        }
        if let lastName = dict["lastName"] as? String {
            self.lastName = lastName
        }
        if let gender = dict["gender"] as? Int {
            self.gender = gender == 1 ? false : true
        }
        if let avatar = dict["avatar"] as? String {
            self.avatar = avatar
        }
        if let cover = dict["cover"] as? String {
            self.cover = cover
        }
        if let description = dict["description"] as? String {
            self.description = description
        }
        if let friendlist = dict["friendlist"] as? [String: Any] {
            self.friendList = friendlist
        }
        if let isAvailable = dict["isAvailable"] as? Int {
            self.isAvailable = isAvailable == 1 ? false : true
        }
        if let phoneNumber = dict["phone"] as? String {
            self.phone = phoneNumber
        }
    }
    
    func toDict() -> [String: Any]{
        var userDict = [String: Any]()
        userDict["uid"] = self.uID
        userDict["firstName"] = self.firstName
        userDict["lastName"] = self.lastName
        userDict["gender"] = self.gender ? 0 : 1
        userDict["avartar"] = self.avatar
        userDict["cover"] = self.cover
        userDict["description"] = self.description
        userDict["friendlist"] = self.friendList
        userDict["phone"] = self.phone
        userDict["isAvailable"] = self.isAvailable ? 0 : 1
        return userDict
    }
}
