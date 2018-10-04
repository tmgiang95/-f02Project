//
//  CountryDialCode.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/4/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import Foundation

final class CountryDialCode {
    var name = ""
    var dial_code = ""
    var name_code = ""
    
    init(_ name: String,_ dial_code: String,_ name_code: String) {
        self.name = name
        self.dial_code = dial_code
        self.name_code = name_code
    }
}
