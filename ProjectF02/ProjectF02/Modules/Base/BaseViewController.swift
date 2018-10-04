//
//  BaseViewController.swift
//  Assignment
//
//  Created by Minh Giang on 7/26/18.
//  Copyright © 2018 Minh Giang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: nil) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    
    
}
