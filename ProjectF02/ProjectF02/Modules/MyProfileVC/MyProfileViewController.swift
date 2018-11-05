//
//  MyProfileViewController.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseDatabase

final class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableview: UITableView!
    
    var userinfo: User!
    private var posts = [Post]()
    private var ref : DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        getPost(self.userinfo.uid!) { [weak self] (posts) in
            self?.posts = posts
            self?.profileTableview.reloadData()
        }
    }
    
    func fillData(_ user: User) {
        self.userinfo = user
    }
    
    func configureTableview() {
//        profileTableview.layer.borderWidth = 1
//        profileTableview.layer.borderColor = UIColor.black.cgColor
        profileTableview.dataSource = self
        profileTableview.delegate = self
        profileTableview.registerCell(AvatarTableViewCell.className,PostTableViewCell.className)
    }
    
    func gotoDescriptionvc() {
        let desvc = DescriptionViewController.init(nibName: "DescriptionViewController", bundle: nil)
        desvc.fillData(userinfo)
        navigationController?.pushViewController(desvc, animated: true)
    }
    
    func getPost(_ uID: String, callback: @escaping (([Post]) -> Void)) {
        let ref = Database.database().reference().child("Post").queryOrdered(byChild: "uid").queryEqual(toValue: uID)
        
        ref.observe(.value) { (snapshot) in
            for snap in snapshot.children {
                let data  = (snap as! DataSnapshot).value as! [String: Any]
                let newPos = Post(data)
                self.posts.append(newPos)
                callback(self.posts)
                
                //                    print(post.postid! + post.contentText! + post.uid!)
            }
        }
    }
}

extension MyProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension MyProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = profileTableview.dequeueReusableCell(withIdentifier: AvatarTableViewCell.className, for: indexPath) as? AvatarTableViewCell else {
                return UITableViewCell()
            }
//            let username = self.userinfo.lastName! + " " + self.userinfo.firstName!
//            let coverimage: UIImage = #imageLiteral(resourceName: "cover")
//            let avatarimage: UIImage = #imageLiteral(resourceName: "avatar")
            cell.fillData(userinfo)
            cell.descriptionHandler = { [weak self] in
             self?.gotoDescriptionvc()
            }
            return cell
        } else {
            guard let cell = profileTableview.dequeueReusableCell(withIdentifier: PostTableViewCell.className, for: indexPath ) as? PostTableViewCell else {
                return UITableViewCell()
            }
           cell.fillData(posts[indexPath.row])
           
            
            return cell
        }
        
    }

}
