//
//  AppDelegate.swift
//  Jump Game
//
//  Created by Indah Nurindo on 21/11/2565 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

 var isAllIPad = false
    var isIPadPro = false
    var isIPad11 = false
    var isIPad12 = false
    var isIPad = false
    
    var isIPhoneX = false
    var isIPhonePlus = false
    var isIPhone = false
    var isIPhone5 = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func setupDevice() {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            isAllIPad = true
            switch UIScreen.main.nativeBounds.height {
            case 2388: isIPad11 = true; break
            case 2732: isIPad12 = true; break
            default: isIPadPro = true; break
            }
            
            if isIPad12 || isIPadPro {
                isIPad = true
            }
        case .phone:
            switch UIScreen.main.nativeBounds.height {
            case 2688, 1792, 2436, 2778: isIPhoneX = true; break
            case 1920, 2208: isIPhonePlus = true; break
            case 1334: isIPhone = true; break
            case 1136: isIPhoneX = true; break
            default: isIPhoneX = true; break
            }
        case .tv: break
        default: break
        }
    }
}

