//
//  DatePickerViewController.swift
//  ProjectF02
//
//  Created by Quang Thai on 10/11/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    var doneCallBack: ((_ date: Date) -> Void)!
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayPicker.datePickerMode = .date
        birthdayPicker.maximumDate = Date()
        birthdayPicker.date = Date()
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        doneCallBack(birthdayPicker.date)
        dismiss(animated: true, completion: nil)
    }

}
