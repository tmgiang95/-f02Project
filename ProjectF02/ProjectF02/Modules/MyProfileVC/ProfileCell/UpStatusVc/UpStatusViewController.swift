//
//  UpStatusViewController.swift
//  ProjectF02
//
//  Created by mac one on 11/8/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class UpStatusViewController: UIViewController {

    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var imageViewuser: UIImageView!
    @IBOutlet weak var textfieldContent: UITextField!
    @IBOutlet weak var labelContent: UILabel!
    private let imagePickerController = UIImagePickerController()
    
    private enum ImageMethod {
        
        case camera, photoLibrary
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePicker()
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
    
    private func configureImagePicker() {
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
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
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        dismiss(animated: true, completion: nil)
    }
}
