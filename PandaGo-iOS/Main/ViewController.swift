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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }

    @IBAction func shopButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Shop", bundle: nil)
        let newViewController = storyBoard.instantiateInitialViewController() as! ShopViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func fightButtonAction(_ sender: Any) {
        guard let info = pandaInfo else { return }
        if info.weapon != "N/A" {
            requestFriendList()
        }
        else {
            requestFriendList()
//            let alert = UIAlertController(title: "Not Available", message: "You need to buy weapon first to enter the fight", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true)
        }
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
//        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.loopMode = .loop
        
        animationView.play()
    }
}


extension ViewController {
    func requestFriendList() {
        PandaGoProvider().getFriendList(pandaId: nil, completion: { [weak self] data in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
//                        let pandaInfoResponse = try decoder.decode(PandaInfoResponse.self, from: data)
//                        self?.pandaInfoResponse = pandaInfoResponse
                        
                    } catch {
                        print("error: ", error)
                    }
                }
                
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Fight", bundle: nil)
                    let newViewController = storyBoard.instantiateInitialViewController() as! FriendListViewController
                    newViewController.modalPresentationStyle = .fullScreen
                    newViewController.friendList = "Test"
                    newViewController.myInfo = self?.pandaInfo
                    self?.present(newViewController, animated: true, completion: nil)
                }
                
            }) { error in
                print("error: ", error)
            }
        }
}
