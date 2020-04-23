//
//  SpinnerViewController.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 22/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation
import UIKit

class SpinnerViewController: UIViewController {
  var spinner = UIActivityIndicatorView(style: .medium)
  
  override func loadView() {
    view = UIView()
    view.backgroundColor = .white
    
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    view.addSubview(spinner)
    
    spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  func addSpinner(to view: UIView) {
    self.view.frame = view.bounds
    view.addSubview(self.view)
  }
  
  func removeSpinner(from view: UIView) {
    self.view.removeFromSuperview()
  }
  
}
