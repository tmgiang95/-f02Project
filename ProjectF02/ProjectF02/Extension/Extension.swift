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
    
    func registerCells(_ cellIDs: String...) {
        
        cellIDs.forEach { (cellID) in
            self.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        }
    }
}


