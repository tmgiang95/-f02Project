//
//  ViewController.swift
//  ProjectF02
//
//  Created by Tuấn Bờm on 8/28/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth

class ViewController: BaseViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var anotherSignInView: UIView!
    @IBOutlet weak var buttonGoogleLogin: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var sendUID: ((_ uID: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        configureButtonLogin(button: buttonLogin)
        configureButtonLogin(button: buttonGoogleLogin)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func configureButtonLogin(button : UIButton) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: button.frame.size)
        gradient.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: button.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        button.layer.addSublayer(gradient)
    }
    
    
    @IBAction func signInWithGoogleAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func signInAction(_ sender: Any) {
//        let chatVC = ChatViewController()
//        self.navigationController?.pushViewController(chatVC, animated: true)
        guard let email = username.text, let pass = password.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: pass) { (data, error) in
            if let err = error {
                print("Fail to Sign In with Google Account: ",err)
                return
            }
            guard let dt = data else {
                return
            }
            
            print("Sign In Successful with UID: ",dt.user.uid)
//            let chatVC = ChatViewController()
//            self.navigationController?.pushViewController(chatVC, animated: true)
//            let chatViewController = ChatViewController(nibName: "ChatViewController", bundle: nil)
//            chatViewController.uID = dt.user.uid
////            self.sendUID?(dt.user.uid)
//            self.present(chatViewController, animated: true, completion: nil)
            let myprofile = MyProfileViewController(nibName: "MyProfileViewController", bundle:nil)
            self.navigationController?.pushViewController(myprofile, animated: true)
        }
    }
    
    func getUserFromFireBase() -> User {
        var user: User
        
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
}
extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let er = error {
            print("Fail to Sign In with Google Account: ",er)
            return
        }
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (data, error) in
            if let err = error {
                print("Fail to Sign In with Google Account: ",err)
                return
            }
            guard let dt = data else {
                return
            }
            
          
            
            print("Sign In Successful with UID: ",dt.user.uid)
        }
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

