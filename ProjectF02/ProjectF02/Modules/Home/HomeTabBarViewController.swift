//
//  HomeTabBarViewController.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/16/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class HomeTabBarViewController: UITabBarController {
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func passHomeData(_ user: User){
        self.user = user
        configureSubView()
    }
 
    fileprivate func configureSubView() {
        guard let u = self.user else {
            return
        }
        let chatHomeVC = ChatHomeViewController()
        chatHomeVC.passData(u)
        chatHomeVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "messages"), selectedImage: nil)
        let newFeedsVC = NewFeedsViewController()
        newFeedsVC.tabBarItem = UITabBarItem(title: "NewsFeed", image: UIImage(named: "newsfeed"), selectedImage: nil)
        let myProfileVC = MyProfileViewController()
        myProfileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)
        viewControllers = [newFeedsVC, chatHomeVC, myProfileVC]
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = "NewsFeed"
        tabBar.tintColor = .black
    }

}
