//
//  FriendListViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController {
    @IBOutlet weak var friendListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        friendListTableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FriendListViewController: UITableViewDelegate {
    
}

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell") as? FriendListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configuration(name: "Suji Kim")
        
        return cell
    }
    
    
}
