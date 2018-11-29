//
//  DeviceType.swift
//  ProjectF02
//
//  Created by Quang Thai on 11/29/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

public enum DeviceType {
    
    case unknown
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneX
    case iPhoneXsMax
    case iPadSmall
    case iPadMedium
    case iPadBig
}

public final class DetectDevice {
    
    class var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    class var maxLength: CGFloat {
        return max(width, height)
    }
    
    class var minLength: CGFloat {
        return min(width, height)
    }
    
    class var zoomed: Bool {
        return UIScreen.main.nativeScale >= UIScreen.main.scale
    }
    
    class var retina: Bool {
        return UIScreen.main.scale >= 2.0
    }
    
    class var phone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var pad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    class var carplay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
    class var televion: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    class var type: DeviceType {
        if phone && maxLength < 568 {
            return .iPhone4
        } else if phone && maxLength == 568 {
            return .iPhone5
        } else if phone && maxLength == 667 {
            return .iPhone6
        } else if phone && maxLength == 736 {
            return .iPhone6Plus
        } else if phone && maxLength == 812 {
            return .iPhoneX
        } else if phone && maxLength == 896 {
            return .iPhoneXsMax
        } else if pad && maxLength == 1024 {
            return .iPadSmall
        } else if pad && maxLength == 1112 {
            return .iPadMedium
        } else if pad && maxLength == 1366 {
            return .iPadBig
        }
        return .unknown
    }
}
