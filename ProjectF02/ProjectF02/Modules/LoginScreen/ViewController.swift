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
        guard let email = username.text, let pass = password.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] (data, error) in
            if let err = error {
                print("Fail to Sign In with Google Account: ",err)
                return
            }
            guard let dt = data else {
                return
            }
            


            self?.getUserFromFirebase(dt.user.uid, callback: { (user: User) in
                // send data into myprofilevc
                let profilevc = MyProfileViewController()
                profilevc.fillData(user)
                
//                let homevc = HomeTabBarViewController()
//                homevc.passHomeData(user)
                self?.navigationController?.pushViewController(profilevc, animated: true)
            })
//                        let p = Post()
//                        Database.database().reference().child("Post").child(String(Int(NSDate().timeIntervalSince1970))).setValue(p.toDict())
           
            
        }
    }
    
    
    @IBAction func signupBtnAction(_ sender: Any) {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func getPost(_ uID: String, callback: ((Post) -> Void)) {
        var posts = [Post]()
        let ref = Database.database().reference().child("Post").queryOrdered(byChild: "uid").queryEqual(toValue: uID)
        ref.observe(.value, with: { _ in ()})
    }
    
    func getUserFromFirebase(_ uID: String,callback: @escaping ((User) -> Void)){
        var user =  User()
        let ref = Database.database().reference().child("User").queryOrdered(byChild: "uid").queryEqual(toValue : uID)
        ref.observe(.value, with:{ (snapshot: DataSnapshot) in
            for snap in snapshot.children {
                let u = (snap as! DataSnapshot).value as! [String: Any]
                user = User(u)
                callback(user)
                print(user.lastName! + " " + user.firstName!)
            }
        })
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
        Auth.auth().signInAndRetrieveData(with: credential) {[weak self]  (data, error) in
            if let err = error {
                print("Fail to Sign In with Google Account: ",err)
                return
            }
            guard let dt = data else {
                return
            }
            self?.getUserFromFirebase(dt.user.uid, callback: { (user: User) in
                let homevc = HomeTabBarViewController()
                homevc.passHomeData(user)
                self?.navigationController?.pushViewController(homevc, animated: true)
            })
            //            let p = Post()
            //            Database.database().reference().child("Post").child(String(Int(NSDate().timeIntervalSince1970))).setValue(p.toDict())
            
        }
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}

