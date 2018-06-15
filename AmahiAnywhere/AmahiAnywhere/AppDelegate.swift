//
//  AppDelegate.swift
//  AmahiAnywhere
//
//  Created by Carlos Puchol on 1/27/18.
//  Copyright © 2018 Amahi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import EVReflection

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let stack = CoreDataStack(modelName: "OfflineFilesModel")!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        
        self.window? = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: StoryBoardIdentifiers.MAIN, bundle: nil)
        var initialViewController: UIViewController? = nil
        if LocalStorage.shared.contains(key: PersistenceIdentifiers.ACCESS_TOKEN) {
            initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationViewController")
        } else {
            initialViewController = mainStoryboard.instantiateInitialViewController()
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        // Set date formatter for EV Reflection
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        EVReflection.setDateFormatter(dateFormatter)
        
        preloadData()
        return true
    }
    
    // MARK: Preload Data
    
    func preloadData() {
        
        // Remove previous stuff (if any)
        do {
            try stack.dropAllData()
        } catch {
            print("Error droping all objects in DB")
        }
        
        for i in 1..<10 {
            // Create some offline files for test
            var offlineFile = OfflineFile(name: "",
                                          share: "Share One",
                                          mime: "text/plain",
                                          size: 7 * 1024 * 1024,
                                          localPath: "",
                                          fileUri: "",
                                          downloadId: Int64(Date().timeIntervalSince1970),
                                          state: 0,
                                          context: stack.context)
            offlineFile.name = "Offline File: \(i)"
        }
        
//        print(offlineFile)
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
