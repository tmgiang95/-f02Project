//
//  NewFeedViewController.swift
//  ProjectF02
//
//  Created by Quang Thai on 10/30/18.
//  Copyright © 2018 VTCA. All rights reserved.
//

import UIKit

final class NewFeedViewController: BaseViewController {

    @IBOutlet weak var newfeedTableView: UITableView!
    
    var listPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newfeedTableView.delegate = self
        newfeedTableView.dataSource = self
    }

}

extension NewFeedViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension NewFeedViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newfeedTableView.dequeueReusableCell(withIdentifier: "NewFeedPostCell") as? NewFeedPostCell else {
            return UITableViewCell()
        }
        cell.fillData(listPost[indexPath.row])
        return cell
    }
}
