//
//  AppDelegate.swift
//  amazoonia
//
//  Created by Daniel Martinez on 26/11/2019.
//  Copyright © 2019 Amazoonia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationBarAppearance = UINavigationBar.appearance()
        let tabBarAppearance = UITabBar.appearance()
        
        navigationBarAppearance.isTranslucent = true
        tabBarAppearance.tintColor = #colorLiteral(red: 0.4245980382, green: 0.5975795388, blue: 0.4042197466, alpha: 1)
        // change navigation item title color
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        navigationBarAppearance.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationBarAppearance.barTintColor = #colorLiteral(red: 0.4235294118, green: 0.5960784314, blue: 0.4039215686, alpha: 1)
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        }
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

