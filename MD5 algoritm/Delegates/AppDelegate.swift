//
//  AppDelegate.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var ImageCache = [String : Data]()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    UserDefaults.standard.register(defaults: [
      Constants.appVersionUserDefaultsKey: "",
      Constants.jsonLoadedToPersistentStoreDefaultsKey: false
    ])
    
    let currentAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let previousVersion = UserDefaults.standard.string(forKey: Constants.appVersionUserDefaultsKey )
    
    if previousVersion == "" {
      // first launch
      
      // load JSON to persistent store
      if let loginModelCodables = parseLocalJSON() {
        let context = persistentContainer.viewContext
        for loginModelCodable in loginModelCodables.loginModel {
          let loginModel = LoginModel(context: context)
          let role = Role(context: context)
          loginModel.id = Int32(loginModelCodable.id)!
          loginModel.name = loginModelCodable.name
          loginModel.avatarUrl = loginModelCodable.avatarURL
          loginModel.password = loginModelCodable.passHash
          
          // TODO: - Implement a way to check for duplicates
          role.id = FacadeAPI.shared.getNewIdForEntityType(Role.self, in: context)!
          role.name = loginModelCodable.role
          loginModel.role = role

          saveContext()
        }
      }
      // set version to UserDefaults
      UserDefaults.standard.setValue(currentAppVersion, forKey: Constants.appVersionUserDefaultsKey)
    } else if previousVersion == currentAppVersion {
      // same version
    } else {
      // other version
      UserDefaults.standard.setValue(currentAppVersion, forKey: Constants.appVersionUserDefaultsKey)
    }
    
    
    
    
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      /*
       The persistent container for the application. This implementation
       creates and returns a container, having loaded the store for the
       application to it. This property is optional since there are legitimate
       error conditions that could cause the creation of the store to fail.
      */
      let container = NSPersistentContainer(name: "MD5_algoritm")
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
  }

}

