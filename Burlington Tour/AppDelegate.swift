//
//  AppDelegate.swift
//  Burlington Tour
//
//  Created by Matthew Fortier on 3/6/18.
//  Copyright © 2018 Matthew Fortier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let itemStore = ItemStore()
        
        let tabController = window!.rootViewController as! UITabBarController
        
        var navController = tabController.viewControllers![0] as! UINavigationController
        let placesController = navController.topViewController as! PlacesTableViewController
        navController = tabController.viewControllers![1] as! UINavigationController
        let toursController = navController.topViewController! as! ToursTableViewController
        
        navController = tabController.viewControllers![2] as! UINavigationController
        let favoritesController = navController.topViewController as! FavoritesViewController
        
        navController = tabController.viewControllers![3] as! UINavigationController
        let notesController = navController.topViewController as! NotesTableViewController
        
        placesController.itemStore = itemStore
        toursController.itemStore = itemStore
        notesController.itemStore = itemStore
        //noteController.itemStore = itemStore

        favoritesController.itemStore = itemStore
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

