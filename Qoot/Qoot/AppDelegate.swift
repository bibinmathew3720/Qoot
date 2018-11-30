//
//  AppDelegate.swift
//  Qoot
//
//  Created by Bibin Mathew on 8/2/18.
//  Copyright © 2018 Cl. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FBSDKLoginKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setNavigationBarProperties()
        localisationMethod()
        initWindow()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        GMSPlacesClient.provideAPIKey(Constant.ApiKeys.googleMapKey)
        GMSServices.provideAPIKey(Constant.ApiKeys.googleMapKey)
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "598957928769-t37gl3jccj8t55e6gp6t7jvtl9a4df3l.apps.googleusercontent.com"
        return true
    }
    
    func initWindow(){
        let secondLogin = UserDefaults.standard.bool(forKey: Constant.VariableNames.isSecondLogIn)
        if secondLogin{
            let homeVC = HomeVC.init(nibName: "HomeVC", bundle: nil)
            let homeNavVC = UINavigationController.init(rootViewController: homeVC)
            let menuVC = MenuVC.init(nibName: "MenuVC", bundle: nil)
            let viewMoreVC = ViewMoreVC.init(nibName: "ViewMoreVC", bundle: nil)
            var slideMenuController:ExSlideMenuController?
            if LanguageManger.shared.currentLanguage == .en {
                slideMenuController = ExSlideMenuController(mainViewController: homeNavVC, leftMenuViewController:menuVC , rightMenuViewController: viewMoreVC)
            }
            else{
                slideMenuController = ExSlideMenuController(mainViewController: homeNavVC, leftMenuViewController:viewMoreVC , rightMenuViewController: menuVC)
            }
            self.window?.rootViewController = slideMenuController
        }
        else{
            let languageVC = LanguageVC.init(nibName: "LanguageVC", bundle: nil)
            self.window?.rootViewController = languageVC
        }
    }
    
    func localisationMethod(){
        //Mark: Localisation handle
        var selectedLanguage:Languages?
        let language = UserDefaults.standard.value(forKey: "language")
        if let _language = language as? String{
            
            selectedLanguage = (_language == "en") ? .en : .ar
        }else{
            selectedLanguage =  .en
        }
        LanguageManger.shared.setLanguage(language: selectedLanguage!)
    }
    
    func setNavigationBarProperties(){
        UINavigationBar.appearance().barTintColor = Constant.Colors.CommonMeroonColor
        UINavigationBar.appearance().tintColor = Constant.Colors.CommonMeroonColor
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont(name: Constant.Font.Bold, size: 20)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var appUrl: Bool = false
        switch ApplicationController.applicationController.loginType {
            
        case .faceBook:
            appUrl = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        case .googlePlus:
            appUrl = GIDSignIn.sharedInstance().handle(url as URL?, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        default: print("default")
        }
        return appUrl
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Qoot")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
    }

}

extension Notification.Name {
    static let postNotification = Notification.Name("LoginNotification")
    static let menuResetNotification = Notification.Name("ResetMenuNotification")
}

