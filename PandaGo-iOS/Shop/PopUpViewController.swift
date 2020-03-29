//
//  PopUpViewController.swift
//  PandaGo-iOS
//
//  Created by Param Bole on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    var weaponName:String = ""

    @IBOutlet weak var popUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: weaponName)
        popUp.setImage(image, for: .normal)
    }
    
    
    

    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
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
