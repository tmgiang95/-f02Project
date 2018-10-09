//
//  User.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/18/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

class User {
    var UID: String?
    var firstName: String?
    var lastName: String?
    var birthday: String?
    var gender: Bool = true
    var avatar: String?
    var cover: String?
    var description: String?
    var friendList = [String]()
    var isAvailable: Bool = false
//    init(_ UID: String?,_ firstName: String?,_ lastName: String?,_ birthday: String?,_ gender:Bool,_ avatar: String?,_ cover: String?,_ description: String?,_ friendList: [String] ) {
//        self.UID = UID
//        self.firstName = firstName
//        self.lastName = lastName
//        self.birthday = birthday
//        self.gender = gender
//        self.avatar = avatar
//        self.cover = cover
//        self.description = description
//        self.friendList = friendList
//    }
    init(_ dict: [String:Any]) {
        if let uid = dict["uid"] as? String{
            self.UID = uid
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
        if let friendlist = dict["friendlist"] as? [String] {
            self.friendList = friendlist
        }
        if let isAvailable = dict["isAvailable"] as? Int {
            self.isAvailable = isAvailable == 1 ? false : true
        }
    }
    init() {
    }
}
