//
//  ShopViewController.swift
//  PandaGo-iOS
//
//  Created by Param Bole on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func wheatButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        self.addChild(popOverVc)
        popOverVc.weaponName = "popupWheat"
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    
    @IBAction func stickButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        self.addChild(popOverVc)
        popOverVc.weaponName = "popupStick"
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    @IBAction func spoonButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        self.addChild(popOverVc)
        popOverVc.weaponName = "popupSoon"
        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
    @IBAction func bambooButton(_ sender: Any) {
        let popOverVc = UIStoryboard(name:"Shop", bundle: nil).instantiateViewController(identifier: "sbPopUpId") as! PopUpViewController
        self.addChild(popOverVc)
        popOverVc.weaponName = "popupBamboo"
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
