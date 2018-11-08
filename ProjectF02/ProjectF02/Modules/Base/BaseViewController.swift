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
    
//    func showAlert(title: String, content: String, titleButton: String, action: (() -> Void)? = nil) {
//        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
//        let action = UIAlertAction(title: titleButton, style: .default) { (_) in
//            action?()
//        }
//        alertVC.addAction(action)
//        present(alertVC, animated: true, completion: nil)
//    }
//
//    func showActionSheet( title: String, content: String,
//                         cancelButtonTitle: String = "Cancel", cancelButtonAction: (() -> Void)? = nil,
//                          otherButtons: [(title: String, action: (() -> Void) )] ) {
//        let actionSheet = UIAlertController(title: title, message: content, preferredStyle: .actionSheet)
//        for button in otherButtons {
//            let action = UIAlertAction(title: button.title, style: .default, handler: { (_) in
//                button.action()
//            })
//            actionSheet.addAction(action)
//        }
//        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (_) in
//            cancelButtonAction?()
//        })
//        actionSheet.addAction(cancelAction)
//        present(actionSheet, animated: true, completion: nil)
//    }
    
}
