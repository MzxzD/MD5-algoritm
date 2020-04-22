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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func setupUI(using loginModel: LoginModel) {
    self.userImageView.image = nil
    self.userImageView.backgroundColor = nil
    
    self.userFullNameLabel.text = loginModel.name
    self.roleLabel.text = loginModel.role?.name ?? ""
    self.spinner.addSpinner(to: self.userImageView)
    FacadeAPI.shared.getImage(from: loginModel.avatarUrl!) { (wrappedImage) in
      self.spinner.removeSpinner(from: self.userImageView)
      if let image = wrappedImage {
        self.userImageView.image = image
      } else {
        self.userImageView.backgroundColor = .black
      }
    }
  }
}
