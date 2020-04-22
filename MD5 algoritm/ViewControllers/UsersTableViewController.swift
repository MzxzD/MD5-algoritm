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
    tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "usersCell")
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    managedContext = appDelegate.persistentContainer.viewContext
    fetchDataSourceForTableView()
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
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showUser", sender: indexPath)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let indexPath = sender as? IndexPath {
      switch segue.identifier {
      case "showUser":
        let userViewController = segue.destination as! UserViewController
        userViewController.user = loginModelObjects![indexPath.row]
      default:
        return
      }
    }
  }
  
  // MARK: - Private methods
  
  private func fetchDataSourceForTableView() {
    if let managedContext = self.managedContext {
      let loginModelFetchRequest: NSFetchRequest<LoginModel> = LoginModel.fetchRequest()
      loginModelFetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
      do {
      let loginModelArray =  try managedContext.fetch(loginModelFetchRequest)
        loginModelObjects = loginModelArray
        
      } catch {
        // error
      
      }
    }
  }
}
