//
//  NewFeedsViewController.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/16/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class NewFeedsViewController: BaseViewController {

    @IBOutlet weak var bottomContraintBottomView: NSLayoutConstraint!
    @IBOutlet weak var tableview: UITableView!
    var searchBar: UISearchBar?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboard()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        configureSearchBar()
    }
    
    private func configureKeyboard() {
        hideKeyboardWhenTapAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func configureSearchBar(){
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        self.searchBar = searchBar
        self.searchBar!.placeholder = "Search"
        let rightNavBarButton = UIBarButtonItem(customView:self.searchBar!)
        tabBarController?.navigationItem.rightBarButtonItem = rightNavBarButton
        self.searchBar!.delegate = self
    }
    
    
    // MARK: - Handle Keyboard Logic
    private func hideKeyboardWhenTapAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard() {
        self.searchBar!.text = ""
        self.searchBar!.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        guard let userInfo = sender.userInfo,
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                return
        }
        var height = keyboardFrame.cgRectValue.height
        if #available(iOS 11.0, *),  // Remove safearea bottom in iPhone X
            let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom,
            (DetectDevice.type == .iPhoneX || DetectDevice.type == .iPhoneXsMax) {
            height -= bottomSafeArea
        }
        bottomContraintBottomView.constant = height
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
        
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        bottomContraintBottomView.constant = 0
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
}


