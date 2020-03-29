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
    var myPandaInfo: Panda?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mypanda = myPandaInfo else { return }
        guard let yourpanda = yourPandaInfo else { return }
        myPandaNameLabel.text = mypanda.name
        myPandaPointLabel.text = "\(mypanda.points)p"
        let mypandaImageName = mypanda.weapon.lowercased()+"PandaL"
        myPandaImageView.image = UIImage(named: mypandaImageName)
        yourPandaNameLabel.text = yourpanda.name
        yourPandaPointLabel.text = "\(yourpanda.points)p"
        let yourpandaImageName = yourpanda.weapon.lowercased()+"PandaR"
        yourPandaImageView.image = UIImage(named: yourpandaImageName)
        
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.showFightResult()
        }
    }
    
    func showFightResult() {
        
        var result = ""
        guard let yourpanda = yourPandaInfo else { return }
        guard let mypanda = myPandaInfo else { return }
        let mypoint = mypanda.points
        let yourpoint = yourpanda.points
        
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
        popOverVc.yourId = yourpanda._id
        popOverVc.myId = mypanda._id
        self.addChild(popOverVc)

        popOverVc.view.frame = self.view.frame
        self.view.addSubview(popOverVc.view)
        popOverVc.didMove(toParent: self)
    }
}
