//
//  AppDelegate.swift
//  NoStoryboard
//
//  Created by Павел Виноградов on 21.05.2022.
//

import UIKit
import CoreData

@available(iOS 15.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navController = UINavigationController(rootViewController: EmployeeListVC())
        navController.navigationBar.prefersLargeTitles = false
        navController.navigationBar.isHidden = false
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        self.window = window
        
//        fatalError("\(UIScreen.main.bounds.size)")
        
        return true
    }
}

