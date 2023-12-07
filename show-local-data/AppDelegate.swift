//
//  AppDelegate.swift
//  show-local-data
//
//  Created by James on 06/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window else { return true }
        let vc = CreatDataViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }
}

