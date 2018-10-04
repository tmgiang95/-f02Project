//
//  CountryListViewController.swift
//  ProjectF02
//
//  Created by Quang Thai on 9/8/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

class CountryListViewController: BaseViewController {
    //MARK:- Outlet
    @IBOutlet weak var searchTextfield: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    
    //MARK:- Properties
    var countryCodeList = [CountryDialCode]()
    var displayList = [CountryDialCode]()
    var codeSelected: ((_ code: CountryDialCode) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        getListDialCode()
    }
    
    @IBAction func searchTextFieldChange(_ sender: UITextField) {
        if let searchStr = sender.text, searchStr != "" {
            displayList = countryCodeList.filter({ (countryDialogCode) -> Bool in
                countryDialogCode.name.contains(searchStr)
            })
            countryTableView.reloadData()
        } else {
            displayList = countryCodeList
            countryTableView.reloadData()
        }
    }
    
    
    private func initTableView(){
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.register(UINib(nibName: "CountryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryListTableViewCell")
    }
    
    private func getListDialCode(){
        if let path = Bundle.main.path(forResource: "CountryList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let jsonStrResult = jsonResult as? [[String: Any]] {
                    for dict in jsonStrResult {
                        let countryDialogCode = CountryDialCode("", "", "")
                        if let name = dict["name"] as? String? {
                            countryDialogCode.name = name!
                        }
                        if let dial_code = dict["dial_code"] as? String? {
                            countryDialogCode.dial_code = dial_code!
                        }
                        if let name_code = dict["code"] as? String? {
                            countryDialogCode.name_code = name_code!
                        }
                        countryCodeList.append(countryDialogCode)
                        displayList.append(countryDialogCode)
                    }
                }
                countryTableView.reloadData()
            } catch {
                print("error")
            }
        }
    }
}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        codeSelected?(displayList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countryTableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell") as? CountryListTableViewCell else {
            return UITableViewCell()
        }
        cell.fillData(displayList[indexPath.row])
        return cell
    }
    
    
}
