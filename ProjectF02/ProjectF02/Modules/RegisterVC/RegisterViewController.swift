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
    @IBOutlet weak var birthdayTextfield: UILabel!
    
    //MARK:- properties
    private var dataRef : DatabaseReference!
    private var isFemale: Bool = true
    private var birthday: Date = Date()
    private var dialCode = ""
    
    //MARK:- lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGenderView()
        let countryViewTap = UITapGestureRecognizer(target: self, action: #selector(handleCountryViewTap(sender:)))
        countryView.addGestureRecognizer(countryViewTap)
        
        let birthdayViewTap = UITapGestureRecognizer(target: self, action: #selector(handleBirthdayViewTap(sender:)))
        birthdayView.addGestureRecognizer(birthdayViewTap)
        dataRef = Database.database().reference()
        
        birthdayTextfield.text = Date().getDateString()
    }
    
    //MARK:- functions
    @objc func handleCountryViewTap(sender: UITapGestureRecognizer? = nil){
        let countryVC = CountryListViewController()
        countryVC.codeSelected = { [weak self] (code: CountryDialCode) in
            self?.countryText.text = code.name_code
            self?.dialCodeLabel.text = code.dial_code
            self?.dialCode = code.dial_code
        }
        navigationController?.pushViewController(countryVC, animated: true)
    }
    
    @objc func handleBirthdayViewTap(sender: UITapGestureRecognizer? = nil){
        let birthdayVC = DatePickerViewController()
        birthdayVC.modalPresentationStyle = .overFullScreen
        present(birthdayVC, animated: true, completion: nil)
        birthdayVC.doneCallBack = { [weak self] (date) in
            self?.birthdayTextfield.text = date.getDateString()
        }
        
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
            let userInfo = User([String: Any]())
            userInfo.uID = user.uid
            if let firstName = self.firstNameTextfield.text {
                userInfo.firstName = firstName
            }
            if let lastName = self.lastnameTextfield.text {
                userInfo.lastName = lastName
            }
            if let phone = self.phoneTextfield.text {
                userInfo.phone = "\(self.dialCode)\(phone)"
            }
            userInfo.birthday = self.birthday.timeIntervalSince1970
            userInfo.gender = self.isFemale
            userInfo.avatar = ""
            userInfo.cover = ""
            userInfo.description = ""
            userInfo.friendList = [String: Any]()
            self.dataRef.child("User").setValue(userInfo.toDict())
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

extension Date {
    func getDateAfter(_ value : Int, _ component : Calendar.Component) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        return dateFormatter.string(from: self)
    }
}
