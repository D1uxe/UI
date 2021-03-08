//
//  AppDelegate.swift
//  vkClient
//
//  Created by MacBook Pro on 25.10.2020.
//

import UIKit
import Firebase
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //Realm.Configuration.defaultConfiguration = Realm.Configuration( deleteRealmIfMigrationNeeded: true)
        return true
    }

   

}

