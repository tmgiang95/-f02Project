//
//  MyProfileViewController.swift
//  ProjectF02
//
//  Created by User on 9/20/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

final class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableview: UITableView!
    
    var userinfo: User!
    private var posts = [Post]()
    private var ref : DatabaseReference?
    private var databaseHandle: DatabaseHandle?
    private let imagePickerController = UIImagePickerController()
    private var selectImageType: ImageType = .avatar
    
     enum ImageType {
        
        case avatar, cover
    }
    
    private enum ImageMethod {
        
        case camera, photoLibrary
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        configureImagePicker()
        getPost(self.userinfo.uid!) { [weak self] (posts) in
            self?.posts = posts
            self?.profileTableview.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//       tabBarController?.hidesBottomBarWhenPushed = true
        tabBarController?.navigationItem.title = "My Profile"
    }
    
    func fillData(_ user: User) {
        self.userinfo = user
    }
    
    private func configureImagePicker() {
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
    }
    
    func configureTableview() {
        profileTableview.dataSource = self
        profileTableview.delegate = self
        profileTableview.registerCell(AvatarTableViewCell.className,PostTableViewCell.className)
    }
    
    private func selectImageMethod(_ method: ImageMethod) {
        
        switch method {
        case .photoLibrary:
            imagePickerController.sourceType = .photoLibrary
        case .camera:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
            } else {
               let alert = UIAlertController(title: "Error", message: "Không tìm thấy camera!", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func gotoDescriptionvc() {
        let desVC = DescriptionViewController()
        desVC.fillData(userinfo)
        navigationController?.pushViewController(desVC, animated: true)
    }
    
    func  gotoUpstatusvc() {
        let statusVC = UpStatusViewController()
        navigationController?.pushViewController(statusVC, animated: true)
    }
    
    func uploadProfileimage(data: Data, _ imagetype: ImageType ) {
        var childnode: String
        if imagetype == .cover{
            childnode = "cover"
        }
        else {
            childnode = "avatar"
        }
        let storageref = Storage.storage().reference().child(childnode).child("test.png")
        let uploadmetaData = StorageMetadata()
        uploadmetaData.contentType = "image/png"
        let uploadtask = storageref.putData(data, metadata: uploadmetaData) { (metadata, error) in
            if ( error != nil ) {
                print("error")
            } else {
                print("metadata: \(metadata)")
            }
        }
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
            cell.upstatusAction = { [weak self ] in
                self?.gotoUpstatusvc()
            }
            cell.editavatarAction = { [weak self ] in
                let alert = UIAlertController(title: "Sửa ảnh đại diện", message: "Chọn ảnh đại diện từ ... ", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "camera", style: .default , handler:{ (UIAlertAction)in
                    self?.selectImageMethod(.camera)
                }))
                alert.addAction(UIAlertAction(title: "Thư viện", style: .default , handler:{ (UIAlertAction)in
                    self?.selectImageMethod(.photoLibrary)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self?.selectImageType = .avatar
                self?.present(alert, animated: true, completion: nil)
            }
            cell.editcoverAction = { [weak self ] in
                let alert = UIAlertController(title: "Sửa ảnh bìa", message: "Chọn ảnh bìa từ ... ", preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "camera", style: .default , handler:{ (UIAlertAction)in
                    self?.selectImageMethod(.camera)
                }))
                alert.addAction(UIAlertAction(title: "Thư viện", style: .default , handler:{ (UIAlertAction)in
                   self?.selectImageMethod(.photoLibrary)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self?.selectImageType = .cover
                self?.present(alert, animated: true, completion: nil)
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

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        switch selectImageType {
        case .avatar:
            if let avatarpicked = info[UIImagePickerControllerOriginalImage] as? UIImage,
                let imagedata = UIImagePNGRepresentation(image) {
                uploadProfileimage(data: imagedata, .avatar)
            }
        case .cover:
            if let avatarpicked = info[UIImagePickerControllerOriginalImage] as? UIImage,
                let dataimage = UIImagePNGRepresentation(image) {
                uploadProfileimage(data: dataimage, .cover)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
