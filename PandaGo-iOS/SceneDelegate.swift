//
//  SceneDelegate.swift
//  PandaGo-iOS
//
//  Created by Suji Kim on 3/28/20.
//  Copyright © 2020 sjkim. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        print("Scene willConnectTo.")
        
        // If this scene's self.window is nil then set a new UIWindow object to it.
        self.window = self.window ?? UIWindow()
        
        let userId = UserDefaults.standard.string(forKey: "_id")
        if userId != nil {
            print("ALREADY SIGNED IN")
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateInitialViewController() as! ViewController
           
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = newViewController
        } else {
            print("DFDFDF")
            let storyboard : UIStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
            let newViewController = storyboard.instantiateInitialViewController() as! SignInStep1ViewController
           
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = newViewController
        }
               
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        print("sceneDidDisconnect.")
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive.")
    }
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneWillResignActive.")
    }
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground.")
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("sceneDidEnterBackground.")
    }
}
