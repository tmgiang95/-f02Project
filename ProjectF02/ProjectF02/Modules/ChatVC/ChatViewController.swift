//
//  ChatViewController.swift
//  ProjectF02
//
//  Created by MinhGiang on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: BaseViewController {
    
    @IBOutlet weak var messTableView: UITableView!
    @IBOutlet weak var messTF: UITextField!
    
    //    private var messSendArray = [Messages(content: "Hello")]
    //    private var messReceiveArray = [Messages(content: "Hi")]
    private var messages = [Message]()
    
    private var ref: DatabaseReference!
    private var refChat : DatabaseHandle!
    private var curUser : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        messTableView.registerCell(ChatTableViewCell1.className)
        messTableView.registerCell(ChatTableViewCell2.className)
        messTableView.delegate = self
        messTableView.dataSource = self
        
       //  navigationController?.popViewController(animated: true)
//        guard let curUser = Auth.auth().currentUser else {
//            return ""
//        }
        
        //ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
        //        let id = snapshot.value as? String
        //        let uIDs = snapshot.value as? [String : Any]
        //
       getMessagesData ()
        
    }
    @IBAction func sendMessAction(_ sender: Any) {
    //    let message = Message(content: messTF.text, isNew: 0, status: 0, time: NSDate(), uID: <#T##String#>)
            
        
    }
    func getMessagesData (){
        self.ref = Database.database().reference()
        let a =  ref.child("Chat").child("0").child("messages")
        
        refChat = a.observe(.value, with: { (snapshot) in
            guard let dict = snapshot.value as? [String: Any] else {
                return
            }
            dict.keys.forEach({ (key: String) in
                if let messageDict = dict[key] as? [String: Any] {
                    let message = Message(dict: messageDict)
                    print(message)
                    self.messages.append(message)
                    self.messTableView.reloadData()
                }
            })
        })
    }
    
    func sendMessagesData() {
        self.ref = Database.database().reference()
        let a =  ref.child("Chat").child("0").child("messages")
//        messages.forEach { (<#Message#>) in
//            <#code#>
//        }
        
    }
    
}
// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        guard let curUser = Auth.auth().currentUser else {
           return UITableViewCell()
        }
        if message.uID == curUser.uid {
            guard let cell = messTableView.dequeueReusableCell(withIdentifier: ChatTableViewCell2.className, for: indexPath) as? ChatTableViewCell2 else {
                return UITableViewCell()
            }
            cell.fillData(message)
            return cell
        } else {
            guard let cell = messTableView.dequeueReusableCell(withIdentifier: ChatTableViewCell1.className, for: indexPath) as? ChatTableViewCell1 else {
                return UITableViewCell()
            }
            cell.fillData(message)
            return cell
        }
    }
}

