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
    
    var friendList: String = ""
    var myInfo: PandaInfoResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        print(friendList)
        friendListTableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
//        cell.configuration(name: "Suji Kim")
        cell.delegate = self
        
        return cell
    }
    
    
}

extension FriendListViewController: FriendTableViewCellDelegate {
    func friendInformation(_ tableViewCell: FriendListTableViewCell, pandaInfo: PandaInfoResponse) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Fight", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FightViewController") as! FightViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.yourPandaInfo = pandaInfo
        newViewController.myPandaInfo = self.myInfo
        self.present(newViewController, animated: true, completion: nil)
    }
}
