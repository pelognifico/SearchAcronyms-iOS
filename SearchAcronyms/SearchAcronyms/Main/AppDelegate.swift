//
//  AppDelegate.swift
//  SearchAcronyms
//
//  Created by Carlos Villamizar on 9/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.setRootViewController(UINavigationController(rootViewController: GeneralRoute.main.scene!),
                                      options: .init(direction: .fade, style: .linear))
        
        return true
    }

}

