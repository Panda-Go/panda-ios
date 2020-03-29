//
//  FriendListTableViewCell.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class FriendListTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(name: String) {
        usernameLabel.text = name
        
    }

}
