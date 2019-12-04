//
//  AppDelegate.swift
//  Todoey
//
//  Created by Jamie on 23/08/2019.
//  Copyright © 2019 Olympus KeyMed. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
//        let data = Data()
//        data.name = "Jamie"
//        data.age = 41
//        
        do {
            _ = try Realm()
//            try realm.write {
//                realm.add(data)
        } catch {
            print("Error initialising new realm, \(error)")
        }
    
        
        return true
    }

//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
//    }
//
    // MARK: - Core Data stack
    
//    // variable only called when its needed
//    lazy var persistentContainer: NSPersistentContainer = {//default - sqllite database
//
//        let container = NSPersistentContainer(name: "DataModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    // saves data when the app is terminated
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
}

