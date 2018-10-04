//
//  Constants.swift
//  ProjectF02
//
//  Created by admin on 9/13/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Firebase
struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
