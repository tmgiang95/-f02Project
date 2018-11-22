//
//  DescriptionViewController.swift
//  ProjectF02
//
//  Created by mac one on 10/30/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var labelbirthday: UILabel!
    @IBOutlet weak var labeladress: UILabel!
    @IBOutlet weak var labelortherinfor: UILabel!
    @IBOutlet weak var labelemail: UILabel!
    @IBOutlet weak var labelphonenumber: UILabel!
    @IBOutlet weak var labelgender: UILabel!
    
    
    var userdescription: User?
    @IBOutlet weak var descriptiontableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUserinfomation()
    }
    
    func fillUserinfomation() {
        labelname.text = (userdescription?.firstName ?? "chưa có") + " " + (userdescription?.lastName ?? "" )
        labelbirthday.text = "chưa có"
        labeladress.text = userdescription?.adress ?? "chưa có"
        labelemail.text = userdescription?.email ?? "chưa có"
        labelphonenumber.text = userdescription?.phone ?? "chưa có"
        if userdescription?.gender == true {
            labelgender.text = "Nam"
        }
        else {
            labelgender.text = "Nữ"
        }
        labelortherinfor.text = userdescription?.description ?? "chưa có"

    }
    
    func  fillData(_ userdes: User) {
        self.userdescription  = userdes
    }

    @IBAction func buttonEditNameaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditbirthdayaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditgenderaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditphoneaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditemailaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditadressaction(_ sender: Any) {
    }
    
    @IBAction func buttonEditortherinfoaction(_ sender: Any) {
    }
    
}
