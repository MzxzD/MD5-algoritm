//
//  UsersTableViewController.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import UIKit
import CoreData

class UsersTableViewController: UITableViewController {
  
  private var managedContext: NSManagedObjectContext!
  private var fetchedResultsController: NSFetchedResultsController<LoginModel>?
  private var loginModelObjects: [LoginModel]?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let lol =  parseLocalJSON()
//    let hmm = lol?.loginModel
//
//    hmm?.forEach({ (hm) in
//      downloadImage(using: hm.avatarURL) { (wrappedData) in
//        if let unwrappedData = wrappedData.data {
//          if let image = UIImage(data: unwrappedData) {
//            self.images.append(image)
//          }
//        }
//      }
//    })
//    tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "usersCell")
    tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "usersCell")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    managedContext = appDelegate.persistentContainer.viewContext
    fetchDataSourceForTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let passwords = ["lele22", "spinoff3", "kick_ass", "underscore", "need aspirin", "cloverfield", "sadKeanu", "catnip", "fluffy", "password", "blueeyes", "limit"]
    let hasedpass = passwords.map({ $0.hashed(.md5)?.uppercased() })
    
    for lol in loginModelObjects! {
      for pas in hasedpass {
        if pas! == lol.password! {
          print("BINGOOOO!!")
        }
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return loginModelObjects?.count ?? 0
  }
  
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UserTableViewCell
    cell.setupUI(using: loginModelObjects![indexPath.row])
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  
  
  // MARK: - Private methods
  
  private func fetchDataSourceForTableView() {
    if let managedContext = self.managedContext {
      let loginModelFetchRequest: NSFetchRequest<LoginModel> = LoginModel.fetchRequest()
      loginModelFetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
      do {
      let loginModelArray =  try managedContext.fetch(loginModelFetchRequest)
        loginModelObjects = loginModelArray.sorted(by: {$0.id > $1.id})
      } catch {
        // error
      
      }
//      fetchedResultsController = NSFetchedResultsController(fetchRequest: loginModelFetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)

      
    }
  }
}
