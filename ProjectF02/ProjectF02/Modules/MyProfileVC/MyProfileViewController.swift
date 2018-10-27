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
    
    override func viewWillAppear(_ animated: Bool) {
        getPost(userinfo.uid!) { (post) in
            self.posts.count
        }
    }
    
    func fillData(_ user: User)
    {
     self.userinfo = user
    }
    
    func configureTableview() {
        ProfileTableview.dataSource = self
        ProfileTableview.delegate = self
        ProfileTableview.registerCell(AvatarTableViewCell.className,PostTableViewCell.className)
    }
    
    func getPost(_ uID: String, callback: @escaping ((Post) -> Void)) {
            var post = Post()
            let ref = Database.database().reference().child("Post").queryOrdered(byChild: "uid").queryEqual(toValue: uID)
            
            ref.observe(.value) { (snapshot) in
                for snap in snapshot.children {
                    let u = (snap as! DataSnapshot).value as! [String: Any]
                    post = Post(u)
                    callback(post)
                    self.posts.append(post)
//                    print(post.postid! + post.contentText! + post.uid!)
                }
            }
    }
    
//    func getUserFromFirebase(_ uID: String,callback: @escaping ((User) -> Void)){
//        var user =  User()
//        let ref = Database.database().reference().child("User").queryOrdered(byChild: "uid").queryEqual(toValue : uID)
//        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
//            for snap in snapshot.children {
//                let u = (snap as! DataSnapshot).value as! [String: Any]
//                user = User(u)
//                callback(user)
//                print(user.lastName! + " " + user.firstName!)
//            }
//        })
//    }
    
    
}

extension MyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // cell động, fix tên tableview
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
