//
//  UpStatusViewController.swift
//  ProjectF02
//
//  Created by mac one on 11/8/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
let FALSE = -1
let TRUE = 1

class UpStatusViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var imagePostup: UIImageView!
    @IBOutlet weak var imageViewuser: UIImageView!
    @IBOutlet weak var buttonAddimage: UIButton!
    @IBOutlet weak var placeHoderLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    private let imagePickerController = UIImagePickerController()
    
    var userforstatusvc: User?
    var isempty: String = ""
    private enum ImageMethod {
        case camera, photoLibrary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePickerAndView()
        configureView()
        configureTextView()
        let avatarref = Storage.storage().reference().child("avatar").child(userforstatusvc?.uid ?? "")
        avatarref.downloadURL { (avatarurl, er) in
            if er != nil {
                print(er as Any)
            }
            else {
                let avtstring = avatarurl?.absoluteString ?? ""
                self.imageViewuser.kf.setImage(with: URL(string: avtstring))
            }
        }
    }
    
    func fillData(_ user: User) {
        self.userforstatusvc = user
    }
    
    private func configureTextView() {
        contentTextView.delegate = self
    }
    
    func configureView() {
        labelUsername.text = (userforstatusvc?.firstName ?? "") + " " + (userforstatusvc?.lastName ?? "")
        imageViewuser.setRounded()
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
    
    func upPostFirebase(_ timest: String, _ timestamp: Double, _ useruppostid: String,_ linkimage: Int) {
        let mypost = Post()
        mypost.contentText = contentTextView.text ?? ""
        mypost.fullName = labelUsername.text
        mypost.time = timestamp
        mypost.postid = useruppostid + timest
        mypost.uid = useruppostid
        mypost.comment = []
        mypost.like = []
//        if linkimage == "co"{
//            mypost.imageLink = "co"
//        }
//        else {
//            mypost.imageLink = "khong"
//        }
        switch linkimage {
        case FALSE:
            mypost.imageLink = FALSE
        case TRUE:
            mypost.imageLink = TRUE
        default:
            print("loi cmnr")
        }
        let postref = Database.database().reference().child("Post").child(timest)
        postref.setValue(mypost.toDict())
        
    }
    
    private func configureImagePickerAndView() {
        buttonAddimage.layer.cornerRadius = 15
        buttonAddimage.layer.borderColor = UIColor.lightGray.cgColor
        buttonAddimage.layer.borderWidth = 0.3
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
    }
    
//    func isimageIsNull(imageName : UIImage) -> Bool
//    {
//
//        let size = CGSize(width: 0, height: 0)
//        if (imageName.size.width == size.width)
//        {
//            return true
//        }
//        else
//        {
//            return false
//        }
//    }
    
    @IBAction func buttonUppostAction(_ sender: Any) {
        let nilimage: UIImage = UIImage()
        let mydate = Date()
        let mytimestamp = mydate.timeIntervalSince1970
        let strmydate: String = String(format: "%.0f", mytimestamp)
        
        if  let text = contentTextView.text, !text.isEmpty, imagePostup.image != nil  {
            let nildata: Data = Data()
            let imagepick = imagePostup.image
            let newsize = CGSize(width: 414, height: 250)
            
            let imagedata = UIImageJPEGRepresentation(imagepick?.resizeImage(targetSize: newsize) ?? nilimage, 0.5)
            let storageref = Storage.storage().reference().child("post").child(userforstatusvc?.uid ?? "").child((userforstatusvc?.uid ?? "")+strmydate)
            let uploadmetaData = StorageMetadata()
            uploadmetaData.contentType = "image/jpg"
            storageref.putData(imagedata ?? nildata, metadata: uploadmetaData) { (metadata, error) in
                if ( error != nil ) {
                    print("error")
                } else {
                    storageref.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                        }
                        else
                        {
                            self.upPostFirebase(strmydate, mytimestamp,self.userforstatusvc?.uid ?? "",TRUE)
                        }
                    })
                }
            }
            dismiss(animated: true, completion: nil)
        }
        else if let texts = contentTextView.text, !texts.isEmpty, imagePostup.image == nil {
            upPostFirebase(strmydate, mytimestamp, self.userforstatusvc?.uid ?? "", FALSE)
            dismiss(animated: true, completion: nil)
        }
        else if let mytext = contentTextView.text, mytext.isEmpty ==  true ,  imagePostup.image == nil {
            let alrt = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập gì!", preferredStyle: .alert)
            let okbtn = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alrt.addAction(okbtn)
            self.present(alrt,animated: true,completion: nil)
        }
        else if let mytex = contentTextView.text, mytex.isEmpty == true, imagePostup.image != nil {
            upPostFirebase(strmydate, mytimestamp, self.userforstatusvc?.uid ?? "", TRUE)
            dismiss(animated: true, completion: nil)
        }
        else {
            print("404")
        }
        
    }
    
    @IBAction func backButtonaction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonAddimageAction(_ sender: Any) {
        let alert = UIAlertController(title: "Thêm ảnh", message: "Thêm ảnh cho bài viết từ ... ", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "camera", style: .default , handler:{ (UIAlertAction)in
            self.selectImageMethod(.camera)
        }))
        alert.addAction(UIAlertAction(title: "Thư viện", style: .default , handler:{ (UIAlertAction)in
            self.selectImageMethod(.photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UpStatusViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let newsize = CGSize(width: 414, height: 200)
        if let imagepicked = info[UIImagePickerControllerOriginalImage] as? UIImage  {
            imagePostup.image =  imagepicked.resizeImage(targetSize: newsize)
        }
        dismiss(animated: true, completion: nil)
        
    }
}

extension UpStatusViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeHoderLabel.isHidden = !textView.text.isEmpty
    }
}
