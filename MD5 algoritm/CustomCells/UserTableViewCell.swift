//
//  UserTableViewCell.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userFullNameLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  let spinner = SpinnerViewController()
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
  func setupUI(using loginModel: LoginModel) {
    self.userImageView.image = nil    
    self.userFullNameLabel.text = loginModel.name
    self.roleLabel.text = loginModel.role.name
    self.spinner.addSpinner(to: self.userImageView)
    FacadeAPI.shared.getImage(from: loginModel.avatarUrl ?? "") { [unowned self] (image) in
      self.spinner.removeSpinner(from: self.userImageView)
      self.userImageView.image = image ?? #imageLiteral(resourceName: "NoImage")
    }
  }
}
