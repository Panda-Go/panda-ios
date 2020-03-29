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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: result)
        resultImageView.image = image
    }
    
    @IBAction func goBackToRoomButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
