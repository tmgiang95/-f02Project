//
//  Extension.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/8/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation
import UIKit

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

extension UIView {
    func setViewrounded() {
        self.layer.cornerRadius = ( self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

