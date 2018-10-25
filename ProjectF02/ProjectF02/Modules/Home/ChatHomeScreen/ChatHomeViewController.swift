//
//  ChatHomeViewController.swift
//  ProjectF02
//
//  Created by Minh Giang on 10/16/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import Firebase

final class ChatHomeViewController: BaseViewController {

    @IBOutlet weak var homeChattableView: UITableView!
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configureTableView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Message"
        getChats()
    }
    
//    fileprivate func configureTableView() {
//        homeChattableView.delegate = self
//        homeChattableView.dataSource = self
//    }
    
    func passData (_ user: User){
        self.user = user
        
    }
    
    fileprivate func getChats() {
        let ref = Database.database().reference().child("Chat")
        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            for snap in snapshot.children {
                let chat = (snap as! DataSnapshot).value as! [String: Any]
                let c = Chat(chat)
                print(c)
            }
        })
    }
}

//extension ChatHomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
//}
//
//extension ChatHomeViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
