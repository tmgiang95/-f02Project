//
//  RegisterViewController.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/3/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

final class RegisterViewController: BaseViewController {
    //MARK:- outlet
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var birthdayView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var countryText: UILabel!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAlreadyAccount: UIButton!
    @IBOutlet weak var femaleImg: UIImageView!
    @IBOutlet weak var femaleText: UILabel!
    @IBOutlet weak var maleImg: UIImageView!
    @IBOutlet weak var maleText: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var dialCodeLabel: UILabel!
    
    //MARK:- properties
    private var dataRef : DatabaseReference!
    
    //MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGenderView()
        let countryViewTap = UITapGestureRecognizer(target: self, action: #selector(handleCountryViewTap(sender:)))
        countryView.addGestureRecognizer(countryViewTap)
        
        dataRef = Database.database().reference()
    }
    
    //MARK:- functions
    @objc func handleCountryViewTap(sender: UITapGestureRecognizer? = nil){
        let countryVC = CountryListViewController()
        countryVC.codeSelected = { [weak self] (code: CountryDialCode) in
            self?.countryText.text = code.name_code
            self?.dialCodeLabel.text = code.dial_code
            print(code.dial_code)
        }
        navigationController?.pushViewController(countryVC, animated: true)
    }
    
    private func configGenderView(){
        femaleView.layer.cornerRadius = 10
        let femaleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleFemaleViewTap(sender:)))
        femaleView.addGestureRecognizer(femaleTapGesture)
        
        maleView.layer.cornerRadius = 4
        let maleTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleMaleViewTap(sender:)))
        maleView.addGestureRecognizer(maleTapGesture)
    }
    
    @objc func handleFemaleViewTap(sender: UITapGestureRecognizer? = nil) {
        femaleImg.tintColor = hexStringToUIColor(hex: "#FFFF")
        femaleText.tintColor = hexStringToUIColor(hex: "#FFFF")
        maleView.backgroundColor = hexStringToUIColor(hex: "#FFFF")
        maleImg.tintColor = hexStringToUIColor(hex: "#4267B2")
        maleText.tintColor = hexStringToUIColor(hex: "#4267B2")
        if #available(iOS 11.0, *) {
            femaleView.backgroundColor = UIColor.init(named: "accent color")
        } else {
            femaleView.backgroundColor = hexStringToUIColor(hex: "#4267B2")
        }
    }
    
    @objc func handleMaleViewTap(sender: UITapGestureRecognizer? = nil) {
        maleView.backgroundColor = hexStringToUIColor(hex: "#4267B2")
        maleImg.backgroundColor = UIColor.white
        maleText.textColor = UIColor.white
        femaleView.backgroundColor = UIColor.white
        femaleImg.tintColor = hexStringToUIColor(hex: "#4267B2")
        femaleText.tintColor = hexStringToUIColor(hex: "#4267B2")
    }
    
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        guard let email = emailTextfield.text else {
            return
        }
        guard let password = passwordTextfield.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                return
            }
            guard let user = authResult?.user else {
                return
            }
            print("\(user.uid) success")
//            let userInfo = UserInfo()
//            userInfo.UID = user.uid
//            if let firstName = self.firstNameTextfield.text {
//                userInfo.firstName = firstName
//            }
//            if let lastName = self.lastnameTextfield.text {
//                userInfo.lastName = lastName
//            }
//            self.dataRef.child("users").setValue(userInfo)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
