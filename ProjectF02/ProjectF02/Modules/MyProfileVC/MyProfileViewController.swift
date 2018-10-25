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
    var userinfo: User!
    var posts = [Post]()
    var ref : DatabaseReference?
    var databaseHandle: DatabaseHandle?
    @IBOutlet weak var ProfileTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
    
    }
    
    func fillData(_ user: User)
    {
     userinfo = user
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return posts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = ProfileTableview.dequeueReusableCell(withIdentifier: AvatarTableViewCell.className, for: indexPath) as? AvatarTableViewCell else {
                return UITableViewCell()
            }
            let username = userinfo.lastName! + " " + userinfo.firstName!
            let coverimage: UIImage = #imageLiteral(resourceName: "cover")
            let avatarimage: UIImage = #imageLiteral(resourceName: "avatar")
            cell.fillData(coverimage , avatarimage, username , avatarimage)
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
