//
//  HomeTabBarViewController.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/16/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubView()
    }
 
    func configureSubView() {
        let chatHomeVC = ChatHomeViewController()
        chatHomeVC.tabBarItem = UITabBarItem(title: "Message", image: nil, selectedImage: nil)
        let newFeedsVC = NewFeedsViewController()
        newFeedsVC.tabBarItem = UITabBarItem(title: "NewsFeed", image: nil, selectedImage: nil)
        let myProfileVC = MyProfileViewController()
        myProfileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        viewControllers = [newFeedsVC, chatHomeVC, myProfileVC]
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = "NewsFeed"
    }

}
