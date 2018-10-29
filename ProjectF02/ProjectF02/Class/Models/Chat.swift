//
//  Chat.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/23/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

final class Chat {
    var id: String? = ""
    var messages = [Message]()
    var uIDs = [String]()
    
    init() {
        
    }
    
    init(_ dict: [String:Any]) {
        if let id = dict["id"] as? String{
            self.id = id
        }
        if let messages = dict["messages"] as? [String: Any] {
            messages.forEach { (arg0) in
                
                let (key, value) = arg0
                self.messages.append(Message(dict: [key:value]))
            }
        }
        if let uIDs = dict["uIDs"] as? [String: Any] {
            uIDs.forEach { (arg0) in
                
                let (_, value) = arg0
                self.uIDs.append(value as! String)
            }
        }
    }
    

}
