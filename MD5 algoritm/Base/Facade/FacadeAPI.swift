//
//  FacadeAPI.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum validationEnum {
  case success
  case error
  case fail
}

class FacadeAPI {
  private var serializationManager: SerializationManager
  private var errorAlert: AlertController
  private var urlSession: URLSessionNetwork
  private var coreDataApi: CoreDataAPI
  

  static let shared = FacadeAPI()
  
  private init() {
    serializationManager = SerializationManager()
    errorAlert = AlertController()
    urlSession = URLSessionNetwork()
    coreDataApi = CoreDataAPI()
  }
  
  func getNewIdForEntityType<T: NSManagedObject>(_ type: T.Type, in managedContext: NSManagedObjectContext) -> Int32? {
    return coreDataApi.getNewIdForEntityType(type.self, in: managedContext)
  }
  
  func getImage(from urlString: String,completion: @escaping(UIImage?)->()) {
    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        if let imageData = appDelegate.ImageCache[urlString] {
          completion(UIImage(data: imageData))
        } else {
          DispatchQueue.init(label: "ImageDownload").async {
            self.urlSession.downloadImage(using: urlString) { (response) in
              DispatchQueue.main.async {
                if let data = response.data {
                  appDelegate.ImageCache[urlString] = data
                  completion(UIImage(data: data))
                } else {
                  completion(nil)
                }
              }
            }
          }
        }
      }
    }
  }
  
  func validatePassword(with input: String, compareTo user: LoginModel) -> validationEnum {
    if let passwordHased = input.hashed(.md5)?.uppercased() {
      if passwordHased == user.password {
        return .success
      } else {
        return .fail
      }
    } else {
      return .error
    }
  }
  
  func showAlertView(from view: UIViewController, with title: String, and message: String) {
    errorAlert.alert(viewToPresent: view, title: title, message: message)
  }
}
