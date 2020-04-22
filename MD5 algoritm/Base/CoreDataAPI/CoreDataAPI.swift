//
//  CoreDataAPI.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 22/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation
import CoreData

class CoreDataAPI {
  
  func getNewIdForEntityType<T: NSManagedObject>(_ type: T.Type, in managedContext: NSManagedObjectContext) -> Int32? {
    let fetchRequest = T.fetchRequest()
    fetchRequest.fetchLimit = 1
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
    
    do {
      let results = try managedContext.fetch(fetchRequest)
      if let id = (results.first as? T)?.value(forKey: "id") as? Int32 {
        if (id > 0) {
          return id + 1
        } else {
          return 1
        }
      } else {
        return 1
      }
    } catch let error as NSError {
      print("Could not fetch \(error.localizedDescription)")
    }
    return nil
  }
  
}
