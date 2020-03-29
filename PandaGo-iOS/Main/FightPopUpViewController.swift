//
//  FightPopUpViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class FightPopUpViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    
    var result: String = ""
    var yourId: String = ""
    var myId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: result)
        resultImageView.image = image
    }
    
    @IBAction func goBackToRoomButtonAction(_ sender: Any) {
        if result == "youlose" {
            updateFightResult(winner: yourId, loser: myId)
        }
        else {
            updateFightResult(winner: myId, loser: yourId)
        }
        
    }
}

extension FightPopUpViewController {
    func updateFightResult(winner:String, loser:String) {
        PandaGoProvider().updateFightResult(winner: winner, loser: loser, completion: { (data) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            print("error: ", error)
        }
    }
}
