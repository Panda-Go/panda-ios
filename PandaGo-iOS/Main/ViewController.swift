//
//  ViewController.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit
import Lottie
import CoreLocation

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
    
    
    var pandaInfo: Panda?
    var friendList: FriendList?
    var pandaInfoResponse: PandaInfoResponse?
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let phoneNumber = UserDefaults.standard.string(forKey: "_id") {
            requestPandaInfo(phoneNumber: phoneNumber)
        }
        getPandaInfo()
        
        if let info = pandaInfo {
            pointLabel.text = "\(info.points)p"
        }
        
        getCurrentLocation()
        setWeapon()
        startAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setWeapon()
        startAnimation()
        getCurrentLocation()
        calculate()
        print(pandaInfo?.points)
    }

    @IBAction func shopButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Shop", bundle: nil)
        let newViewController = storyBoard.instantiateInitialViewController() as! ShopViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.mainViewController = self
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func fightButtonAction(_ sender: Any) {
        guard let info = pandaInfo else { return }
        if info.weapon != "N/A" {
            requestFriendList()
        }
        else {
            let alert = UIAlertController(title: "Not Available", message: "You need to buy weapon first to enter the fight", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    func getPandaInfo() {
        let id = UserDefaults.standard.string(forKey: "_id")
        let name = UserDefaults.standard.string(forKey: "name")
        let weapon = UserDefaults.standard.string(forKey: "weapon")
        let points = UserDefaults.standard.integer(forKey: "points")
        
        if let id = id, let name = name, let weapon = weapon {
            self.pandaInfo = Panda(_id: id, weapon: weapon, points: points, name: name)
        }
    }
    
    func setWeapon() {
        guard let panda = pandaInfo else { return }
        switch panda.weapon {
        case "Wheat":
            weaponImageView.isHidden = false
            weaponImageView.image = UIImage(named: "illustWheat")
        case "Spoon":
            weaponImageView.isHidden = false
            weaponImageView.image = UIImage(named: "spoon")
        case "Stick":
            weaponImageView.isHidden = false
            weaponImageView.image = UIImage(named: "stick")
        case "Bamboo":
            weaponImageView.isHidden = false
            weaponImageView.image = UIImage(named: "bambooCopy2")
        default:
            weaponImageView.isHidden = true
        }
    }
    
    func startAnimation() {
        var animationName = "pandastep1"
        guard let panda = pandaInfo else { return }
        
//        stay longer >= 1500
//        status1 < 1500 && >= 1000
//        status2 >=850 && <1000
//        status3 >= 700 && <850
//        status4 >= 550 && <700
//        status5 < 550
        let point = panda.points
        
        if point >= 1500 {
            chipImageView.isHidden = false
            cokeImageView.isHidden = false
            fryImageView.isHidden = false
            animationName = "pandastep1"
            corona1ImageView.isHidden = true
            corona2ImageView.isHidden = true
            corona3ImageView.isHidden = true
            corona4ImageView.isHidden = true
        }
        else if point < 1500 && point >= 1000 {
            chipImageView.isHidden = true
            cokeImageView.isHidden = true
            fryImageView.isHidden = true
            animationName = "pandastep1"
            corona1ImageView.isHidden = true
            corona2ImageView.isHidden = true
            corona3ImageView.isHidden = true
            corona4ImageView.isHidden = true
        }
        else if point < 1000 && point >= 850 {
            chipImageView.isHidden = true
            cokeImageView.isHidden = true
            fryImageView.isHidden = true
            animationName = "pandastep2"
            corona1ImageView.isHidden = true
            corona2ImageView.isHidden = true
            corona3ImageView.isHidden = true
            corona4ImageView.isHidden = true
        }
        else if point < 850 && point >= 700 {
            chipImageView.isHidden = true
            cokeImageView.isHidden = true
            fryImageView.isHidden = true
            animationName = "pandastep3"
            corona1ImageView.isHidden = true
            corona2ImageView.isHidden = true
            corona3ImageView.isHidden = true
            corona4ImageView.isHidden = true
        }
        else if point < 700 && point >= 550 {
            chipImageView.isHidden = true
            cokeImageView.isHidden = true
            fryImageView.isHidden = true
            animationName = "pandastep4"
            corona1ImageView.isHidden = true
            corona2ImageView.isHidden = true
            corona3ImageView.isHidden = true
            corona4ImageView.isHidden = true
        }
        else {
            chipImageView.isHidden = true
            cokeImageView.isHidden = true
            fryImageView.isHidden = true
            animationName = "pandastep4"
            corona1ImageView.isHidden = false
            corona2ImageView.isHidden = false
            corona3ImageView.isHidden = false
            corona4ImageView.isHidden = false
        }
       
        let animation = Animation.named(animationName)
        
        animationView.animation = animation
//        animationView.center = self.view.center // 애니메이션뷰의 위치설정
        animationView.loopMode = .loop
        
        animationView.play()
    }
}


extension ViewController {
    func requestPandaInfo(phoneNumber: String) {
        PandaGoProvider().getPandaInfo(pandaId: phoneNumber, completion: { [weak self] data in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let pandaInfoResponse = try decoder.decode(PandaInfoResponse.self, from: data)
                    self?.pandaInfoResponse = pandaInfoResponse
                    
                    UserDefaults.standard.set(self?.pandaInfoResponse?._id, forKey: "_id")
                    UserDefaults.standard.set(self?.pandaInfoResponse?.name, forKey: "name")
                    UserDefaults.standard.set(self?.pandaInfoResponse?.weapon, forKey: "weapon")
                    UserDefaults.standard.set(self?.pandaInfoResponse?.points, forKey: "points")
                    
                } catch {
                    print("error: ", error)
                }
            }
            
            
        }) { error in
            print("error: ", error)
        }
    }
    
    func requestFriendList() {
        PandaGoProvider().getFriendList(pandaId: nil, completion: { [weak self] data in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                        let friendList = try decoder.decode(FriendList.self, from: data)
                        self?.friendList = friendList
                    
                } catch {
                    print("error: ", error)
                }
            }
            
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Fight", bundle: nil)
                let newViewController = storyBoard.instantiateInitialViewController() as! FriendListViewController
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.friendList = self?.friendList
                newViewController.myInfo = self?.pandaInfo
                self?.present(newViewController, animated: true, completion: nil)
            }
            
        }) { error in
            print("error: ", error)
        }
    }
    
    func requestWarningSMS(phoneNumber: String) {
        PandaGoProvider().getWarningSMS(phoneNumber: phoneNumber, completion:{ [weak self] data in
        }) { error in
            print("error: ", error)
        }
    }
    
    func requestWashingSMS(phoneNumber: String) {
        PandaGoProvider().getWashHandSMS(phoneNumber: phoneNumber, completion:{ [weak self] data in
        }) { error in
            print("error: ", error)
        }
    }
}


extension ViewController {
    func getCurrentLocation() {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
            print(currentLoc!.coordinate.latitude)
            print(currentLoc!.coordinate.longitude)
        }
    }
    
    func calculate() {
        let homeLat = 34.0256073
        let homeLon = -118.2837413
//        Troy East : 34.0256073,-118.2837413

        var diffLat = currentLoc!.coordinate.latitude - homeLat
        diffLat *= 1000
        var diffLon = currentLoc!.coordinate.longitude - homeLon
        diffLon *= 1000
        
        diffLat = fabs(diffLat)
        diffLon = fabs(diffLon)
        /*
        if diffLat >= 2 && diffLon >= 1 {
            //send warning sms
            if let panda = pandaInfo {
                requestWarningSMS(phoneNumber: panda._id)
            }
        }
        else {
            //send wash hands sms
            if let panda = pandaInfo {
                requestWashingSMS(phoneNumber: panda._id)
            }
        }
        */
        
    }
}
