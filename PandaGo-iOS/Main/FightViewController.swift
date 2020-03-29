//
//  FightViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/29/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class FightViewController: UIViewController {

    @IBOutlet weak var myPandaNameLabel: UILabel!
    @IBOutlet weak var yourPandaNameLabel: UILabel!
    @IBOutlet weak var myPandaPointLabel: UILabel!
    @IBOutlet weak var yourPandaPointLabel: UILabel!
    
    @IBOutlet weak var yourPandaImageView: UIImageView!
    @IBOutlet weak var myPandaImageView: UIImageView!
    
    var yourPandaInfo: PandaInfoResponse?
    var myPandaInfo: PandaInfoResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showFightResult()
        }
    }
    
    func showFightResult() {
        
        var result = ""
        guard let yourpanda = yourPandaInfo else { return }
        guard let mypanda = myPandaInfo else { return }
        let mypoint = Int(mypanda.points) ?? 0
        let yourpoint = Int(yourpanda.points) ?? 0
        
        if mypanda.weapon == yourpanda.weapon {
            if mypoint > yourpoint {
                result = "youwin"
            }
            else {
                result = "youlose"
            }
        }
        else {
            if (mypanda.weapon == "wheat" && ["stick", "spoon", "bamboo"].contains(yourpanda.weapon)) ||
                (mypanda.weapon == "stick" && ["spoon", "bamboo"].contains(yourpanda.weapon) ||
                (mypanda.weapon == "spoon" && yourpanda.weapon == "bamboo")){
                result = "youlose"
            }
            else {
                result = "youwin"
            }
        }
        
        
        let popOverVc = UIStoryboard(name:"Fight", bundle: nil).instantiateViewController(identifier: "FightPopUpViewController") as! FightPopUpViewController
        popOverVc.result = result
        self.addChild(popOverVc)

        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
}
