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
extension UIColor {
    
    static func colorFromHex(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if cString.count != 6 {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var red: CUnsignedInt = 0,
        green: CUnsignedInt = 0,
        blue: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&red)
        Scanner(string: gString).scanHexInt32(&green)
        Scanner(string: bString).scanHexInt32(&blue)
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    static func disableColor(alpha: CGFloat = 1) -> UIColor {
        return .colorFromHex("aaaaaa", alpha: alpha)
    }
    
    static func mainBlueColor(alpha: CGFloat = 1) -> UIColor {
        return .colorFromHex("57ADF9", alpha: alpha)
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

