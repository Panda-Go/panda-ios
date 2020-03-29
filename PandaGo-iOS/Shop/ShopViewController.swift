//
//  ShopViewController.swift
//  PandaGo-iOS
//
//  Created by Param Bole on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    var mainViewController:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func wheatButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        popOverVc.weaponName = "popupWheat"
        self.addChild(popOverVc)

        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    
    @IBAction func stickButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        popOverVc.weaponName = "popupStick"
        self.addChild(popOverVc)
        
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    @IBAction func spoonButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        popOverVc.weaponName = "popupSpoon"
        self.addChild(popOverVc)
        
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    @IBAction func bambooButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        popOverVc.weaponName = "popupBamboo"
        self.addChild(popOverVc)
        
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
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
