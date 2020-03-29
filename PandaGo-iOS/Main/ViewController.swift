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
    
//    let animationView = AnimationView()
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startAnimation()
    }

    func startAnimation() {
        let animation = Animation.named("pandastep1")
        
        animationView.animation = animation
        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.loopMode = .loop
        
        animationView.play()
    }
}

