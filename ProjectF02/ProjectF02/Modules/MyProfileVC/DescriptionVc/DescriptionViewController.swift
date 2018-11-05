//
//  DescriptionViewController.swift
//  ProjectF02
//
//  Created by mac one on 10/30/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var userdescription: User?
    @IBOutlet weak var descriptiontableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func  fillData(_ userdes: User) {
        self.userdescription  = userdes
    }

}
