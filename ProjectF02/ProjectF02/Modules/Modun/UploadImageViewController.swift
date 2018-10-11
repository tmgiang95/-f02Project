//
//  UploadImageViewController.swift
//  ProjectF02
//
//  Created by Vũ Huy on 10/10/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseStorage

class UploadImageViewController: UIViewController {

    @IBOutlet weak var labelShowLink: UILabel!
    @IBOutlet weak var imageShowView: UIImageView!
    
    private let imagePickerController = UIImagePickerController()
    private enum ImageMethod {
        
        case camera, photoLibrary
    }
    let imageName = "\(Date().timeIntervalSince1970).jpg"
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePicker()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function
    private func configureImagePicker() {
        
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
    }
    
    //func Select Image
    private func selectImageMethod(_ method: ImageMethod) {
        
        switch method {
        case .photoLibrary:
            imagePickerController.sourceType = .photoLibrary
        case .camera:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
            } else {
                showAlert(title: "ERROR", content: "Simulator haven't camera...!", titleButton: "OK")
                return
            }
        }
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    // MARK: - Show Alert/ActionSheet
    func showAlert(title: String, content: String, titleButton: String, action: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let action = UIAlertAction(title: titleButton, style: .default) { (_) in
            action?()
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showActionSheet(title: String, content: String,
                         cancelButtonTitle: String = "Cancel", cancelButtonAction: (() -> Void)? = nil,
                         otherButtons: [(title: String, action: (() -> Void))]) {
        let actionSheet = UIAlertController(title: title, message: content, preferredStyle: .actionSheet)
        for button in otherButtons {
            let action = UIAlertAction(title: button.title, style: .default, handler: { (_) in
                button.action()
            })
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: { (_) in
            cancelButtonAction?()
        })
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    //Choise Image
    @IBAction func actionChoiseImage(_ sender: Any) {
        
        showActionSheet(title: "Select Image", content: "Please select image!",
                        otherButtons: [("Take photo from camera", { [weak self] in
                            self?.selectImageMethod(.camera)
                        }), ("Choose from library", { [weak self] in
                            self?.selectImageMethod(.photoLibrary)
                        })]
        )
        
    }
    
    
    @IBAction func actionUploadImage(_ sender: Any) {
        
        guard let image = imageShowView.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
        
        let uploadImageRef = imageReference.child(imageName)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) {
            (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
            self.labelShowLink.text =  metadata?.path
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //return Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        imageShowView.image = image
        dismiss(animated: true, completion: nil)
    }
    
}

