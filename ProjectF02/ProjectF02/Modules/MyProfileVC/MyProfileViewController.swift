//
//  MyProfileViewController.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MyProfileViewController: UIViewController {
    
    var ref : DatabaseReference?
    var databaseHandle: DatabaseHandle?
    @IBOutlet weak var ProfileTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
    
    }
    
    func configureTableview() {
        ProfileTableview.dataSource = self
        ProfileTableview.delegate = self
        ProfileTableview.registerCell(AvatarTableViewCell.className,PostTableViewCell.className)
    }
    
}

extension MyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProfileTableview.frame.height
    }
}
extension MyProfileViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return userinfo.count
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = ProfileTableview.dequeueReusableCell(withIdentifier: AvatarTableViewCell.className, for: indexPath) as? AvatarTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        else {
            guard let cell = ProfileTableview.dequeueReusableCell(withIdentifier: PostTableViewCell.className, for: indexPath ) as? PostTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }
    }
}
