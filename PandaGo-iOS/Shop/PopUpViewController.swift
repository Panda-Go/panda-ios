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
    
    
    @IBAction func buyWeaponButtonAction(_ sender: Any) {
        let id = UserDefaults.standard.string(forKey: "_id")
        if let phoneNumber = id {
            var weapon = ""
            switch weaponName {
            case "popupStick":
                weapon = "Stick"
            case "popupWheat":
                weapon = "Wheat"
            case "popupSpoon":
                weapon = "Spoon"
            case "popupBamboo":
                weapon = "Bamboo"
            default:
                weapon = ""
            }
            
            requestUpdateWeapon(phoneNumber: phoneNumber, weapon: weapon)
        }
    }
    

    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
   
}

extension PopUpViewController {
    func requestUpdateWeapon(phoneNumber:String, weapon: String) {
        PandaGoProvider().updateWeapon(phoneNumber: phoneNumber, weapon: weapon, completion: { [weak self] (data) in
            if let phoneNumber = UserDefaults.standard.string(forKey: "_id") {
                guard let parent = self?.parent as? ShopViewController else { return }
                guard let main = parent.mainViewController as? ViewController else { return }
                main.requestPandaInfo(phoneNumber: phoneNumber)
                print(main.pandaInfo?.points)
            }
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
            
        }) { (error) in
            print("error: ", error)
        }
    }
}
