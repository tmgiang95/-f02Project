//
//  ChatViewController.swift
//  ProjectF02
//
//  Created by MinhGiang95 on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: BaseViewController {
    
    @IBOutlet weak var messTableView: UITableView!
    @IBOutlet weak var messTF: UITextField!
    
    
    private var messages = [Message]()
    private var chat:Chat?
    private var ref: DatabaseReference!
    private var refChat : DatabaseHandle!
    private var curUser = Auth.auth().currentUser
    private var uID : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        messTableView.registerCell(ChatTableViewCell1.className,ChatTableViewCell2.className)
        messTableView.delegate = self
        messTableView.dataSource = self
        messTableView.contentInset = UIEdgeInsetsMake(16, 0, 0, 0)
        if curUser != nil {
            uID = (curUser?.uid)!
        }
        
        getMessagesData()
        
    }
    
    func passChatData(_ chat: Chat) {
        self.chat = chat
    }
    
    @IBAction func sendMessAction(_ sender: Any) {
        
        guard let content = messTF.text ,
            let date = Date().toMillis()
            else {
                return
        }
        
        
        let message = [
            "content" : content ,
            "isNew" : 1,
            "time" : Int64(date),
            "uID" : uID
            ] as [String : Any]
        
        sendMessagesData(message: message, date: Int64(date))
    }
    func getMessagesData (){
        guard let chatContent = self.chat, let chatID = chatContent.id else {
            return
        }
        self.ref = Database.database().reference()
        let a =  ref.child("Chat").child(chatID).child("messages")
        self.messages = chatContent.messages
        self.updateData()
        
        refChat = a.observe(.value, with: { [weak self] (snapshot) in
            guard let wSelf = self, let dict = snapshot.value as? [String: Any] else {
                return
            }
            wSelf.messages = dict.keys.map({ (key: String) -> Message? in
                guard let messageDict = dict[key] as? [String: Any] else {
                    return nil
                }
                return Message(dict: messageDict)
            }).compactMap({$0}).sorted(by: {$0.time < $1.time})
            wSelf.updateData()
           
        })
        
    }
    
    func updateData() {
        self.messTableView.reloadData()
        self.messTF.text = nil
        self.messTF.resignFirstResponder()
        guard !self.messages.isEmpty else {
            return
        }
        self.messTableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0),
                                        at: .bottom,
                                        animated: true)
    }
    
    func sendMessagesData(message : [String : Any] , date : Int64) {
        guard let chatContent = self.chat, let chatID = chatContent.id else {
            return
        }
        self.ref = Database.database().reference()
        
        let messagesFB =  ref.child("Chat").child(chatID).child("messages")
        let key = String(date)
        messagesFB.child(key).setValue(message)
        
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
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/YYYY , hh:mm:ss"
        let messagePre : Message
        if indexPath.row != 0 {
           messagePre = messages[indexPath.row - 1]
        } else {
            messagePre = messages[0]
        }
        let message = messages[indexPath.row]
        var time = ""
        guard let curUser = Auth.auth().currentUser else {
            return UITableViewCell()
        }
        let distance = message.time - messagePre.time
        if  distance > 86400 * 1000 {
            
            time = dateFormat.string(from: Date(timeIntervalSince1970: Double(message.time) / 1000))
        } else {
            time = ""
        }
        if message.uID == curUser.uid {
            guard let cell = messTableView.dequeueReusableCell(withIdentifier: ChatTableViewCell2.className, for: indexPath) as? ChatTableViewCell2 else {
                return UITableViewCell()
            }
            cell.fillData(message, time)
            return cell
        } else {
            guard let cell = messTableView.dequeueReusableCell(withIdentifier: ChatTableViewCell1.className, for: indexPath) as? ChatTableViewCell1 else {
                return UITableViewCell()
            }
            cell.fillData(message, time)
            return cell
        }
    }
}



