//
//  UsersTableViewController.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
  var images = [UIImage]()

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let lol =  parseLocalJSON()
    let hmm = lol?.loginModel
    
    hmm?.forEach({ (hm) in
      downloadImage(using: hm.avatarURL) { (wrappedData) in
        if let unwrappedData = wrappedData.data {
          if let image = UIImage(data: unwrappedData) {
            self.images.append(image)
          }
        }
      }
    })
    tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "usersCell")
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  // MARK: - Table view delegate
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UserTableViewCell
    
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  
  
}
