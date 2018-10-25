//
//  Extension.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/8/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation
import Firebase

extension NSObject {
    class var className : String {
        return String(describing: self)
    }
}
extension UITableView {
    
    func registerCell(_ cellIDs: String...) {
        
        cellIDs.forEach { (cellID) in
            self.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        }
    }
}

extension Date {
    func toMillis() -> Double! {
        return self.timeIntervalSince1970 * 1000
    }
}

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
