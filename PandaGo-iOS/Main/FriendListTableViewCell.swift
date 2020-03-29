//
//  FriendListTableViewCell.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate: AnyObject {
    func friendInformation(_ tableViewCell: FriendListTableViewCell, pandaInfo: PandaInfoResponse)
}

class FriendListTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    weak var delegate:FriendTableViewCellDelegate?
    var pandaInfo: PandaInfoResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(panda: PandaInfoResponse) {
        pandaInfo = panda
        usernameLabel.text = pandaInfo?.name
    }
    
    
    @IBAction func fightButtonAction(_ sender: Any) {
        if let delegates = delegate, let panda = pandaInfo {
            delegates.friendInformation(self, pandaInfo: panda)
        }
    }
    
}
