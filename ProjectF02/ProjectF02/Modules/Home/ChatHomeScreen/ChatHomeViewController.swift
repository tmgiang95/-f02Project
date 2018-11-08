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
    var chatList = [Chat]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uibarbutton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(createNewMessage))
        configureTableView()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Message"
        
        getChats()
    }
    
    @objc func createNewMessage() {
        
    }
    
    fileprivate func configureTableView() {
        homeChattableView.registerCell(HomeChatCell.className)
        homeChattableView.delegate = self
        homeChattableView.dataSource = self
    }
    
    func passData (_ user: User){
        self.user = user
        
    }
    
    fileprivate func getChats() {
        let ref = Database.database().reference().child("Chat")
        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            self.chatList.removeAll()
            for snap in snapshot.children {
                let chat = (snap as! DataSnapshot).value as! [String: Any]
                let c = Chat(chat)
                c.uIDs.forEach({ (uid) in
                    if self.user?.uid == uid {
                        self.chatList.append(c)
                    }
                })
            }
            self.homeChattableView.reloadData()
        })
    }
}

extension ChatHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatvc = ChatViewController()
        let chatContent = self.chatList[indexPath.row]
        chatvc.passChatData(chatContent)
        self.navigationController?.pushViewController(chatvc, animated: true)
    }
}

extension ChatHomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatList.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = self.chatList[indexPath.row]
        guard let cell = homeChattableView.dequeueReusableCell(withIdentifier: HomeChatCell.className, for: indexPath) as? HomeChatCell else {
            return UITableViewCell()
        }
        cell.fillData(chat)
        return cell
    }


}
