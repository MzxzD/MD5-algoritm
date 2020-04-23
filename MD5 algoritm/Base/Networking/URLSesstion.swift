//
//  URLSesstion.swift
//  MD5 algoritm
//
//  Created by Mateo Doslic on 21/04/2020.
//  Copyright © 2020 Mateo Doslic. All rights reserved.
//

import Foundation
import UIKit

class URLSessionNetwork {
  
  func downloadImage(using urlString: String, comletion: @escaping(DataWrapper<Data>)->()) {
   var completionValue = DataWrapper<Data>(data: nil, error: nil)
    if let url = URL(string: urlString) {
      let urlSessionConfig = URLSessionConfiguration.default
      urlSessionConfig.timeoutIntervalForRequest = 60
      let urlSession = URLSession(configuration: urlSessionConfig)
      urlSession.dataTask(with: url) { (data, response, error) in
        completionValue.data = data
        completionValue.error = error?.localizedDescription
        comletion(completionValue)
      }.resume()
    } else {
      completionValue.error = "Failed to cast URL from string"
      comletion(completionValue)
    }
  }
}


