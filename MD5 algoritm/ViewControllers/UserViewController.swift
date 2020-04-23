//
//  ViewController.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import UIKit

final class UserViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  @IBOutlet weak var passwordTextfield: UITextField!
  @IBOutlet weak var containerView: UIView!
  
  var user: LoginModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    containerView.backgroundColor = nil
    nameLabel.text = user.name
    roleLabel.text = user.role.name
    passwordTextfield.isSecureTextEntry = true
    passwordTextfield.delegate = self
    passwordTextfield.returnKeyType = .done
    passwordTextfield.becomeFirstResponder()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)

    FacadeAPI.shared.getImage(from: user.avatarUrl ?? "") { [unowned self] (image) in
      self.userImageView.image = image ?? #imageLiteral(resourceName: "NoImage")
    }
    
  }
  
  // MARK: - TextFiledDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    validatePasswordFromInput()
    return true
  }

  // MARK: - IBAction
  
  @IBAction func login(_ sender: UIButton) {
    validatePasswordFromInput()
  }
  
  // MARK: - Private functions
  
  private func validatePasswordFromInput() {
    if let text = passwordTextfield.text {
      switch FacadeAPI.shared.validatePassword(with: text, compareTo: user) {
      case .success:
        FacadeAPI.shared.showAlertView(from: self, with: "Welcome \(user.name)", and: "You may join the others")
      case .fail:
        FacadeAPI.shared.showAlertView(from: self, with: "Intruder!", and: "You are not \(user.name)! GET OUT! ")
      case .error:
        FacadeAPI.shared.showAlertView(from: self, with: "Whoops...", and: "Something went wrong... Try again...")
      }
    }
  }
  
  private func setupUI() {

  }
  
  @objc func dismissKeyboard() {
      //Causes the view (or one of its embedded text fields) to resign the first responder status.
      view.endEditing(true)
  }
}

