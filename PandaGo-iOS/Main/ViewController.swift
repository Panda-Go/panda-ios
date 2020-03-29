//
//  ViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    @IBOutlet weak var weaponImageView: UIImageView!
    
    @IBOutlet weak var corona1ImageView: UIImageView!
    @IBOutlet weak var corona2ImageView: UIImageView!
    @IBOutlet weak var corona3ImageView: UIImageView!
    @IBOutlet weak var corona4ImageView: UIImageView!
    @IBOutlet weak var chipImageView: UIImageView!
    @IBOutlet weak var cokeImageView: UIImageView!
    @IBOutlet weak var fryImageView: UIImageView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var animationView: AnimationView!
    
    var pandaInfo: PandaInfoResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let info = pandaInfo {
            pointLabel.text = info.points
        }
        startAnimation()
    }

    func startAnimation() {
        var animationName = "pandastep1"
        if let points = pointLabel.text {
            let point = Int(points) ?? 0
            if point >= 5000 {
                chipImageView.isHidden = false
                cokeImageView.isHidden = false
                fryImageView.isHidden = false
            }
        }
        let animation = Animation.named(animationName)
        
        animationView.animation = animation
        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.loopMode = .loop
        
        animationView.play()
    }
}

